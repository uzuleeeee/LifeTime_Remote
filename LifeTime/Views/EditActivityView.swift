//
//  EditActivityView.swift
//  LifeTime
//
//  Created by Mac-aroni on 1/27/24.
//

import SwiftUI

struct EditActivityView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) private var categories: FetchedResults<Category>
    @FetchRequest(sortDescriptors: [SortDescriptor(\.startDate, order: .reverse)]) var activities: FetchedResults<Activity>
    
    @State var activity: Activity
    
    @State private var selectedCategory: Category?
    @State private var name: String = ""
    @State private var startDate: Date = Date()
    @State private var endDate: Date = Date()
    
    @State private var isOverlap = false
    @State private var overlappingActivity: Activity?
    
    @Environment(\.dismiss) private var dismiss
    
    private var disableEdit: Bool {
        if (activity.ended) {
            selectedCategory == nil || endDate.timeIntervalSince(startDate) < 0
        } else {
            selectedCategory == nil || Date().timeIntervalSince(startDate) < 0
        }
    }
    
    var body: some View {
        Form {
            Section("\(activity.name ?? "No name")") {
                // Category picker
                Picker("Category", selection: $selectedCategory) {
                    ForEach(categories) { category in
                        Text(category.wrappedName)
                            .tag(Optional(category))
                    }
                }
                // Name text field
                TextField("Name of activity", text: $name)
                
                // Start date picker
                VStack {
                    DatePicker("From: ", selection: $startDate)
                    if (activity.ended) {
                        DatePicker("To: ", selection: $endDate)
                    }
                }
                
                // Confirm edit button
                Button {
                    let originalName = activity.wrappedName
                    let originalCategory = activity.category
                    let originalStartDate = activity.wrappedStartDate
                    let originalEndDate = activity.wrappedEndDate
                    
                    DataController().editActivity(activity: activity, name: name, selectedCategory: selectedCategory, startDate: startDate, endDate: endDate, context: moc)
                    
                    // Check for overlap
                    let index = activities.firstIndex(of: activity) ?? 0
                    let lastIndex = activities.count - 1
                    isOverlap = false
                    
                    if (index > 0 && index < lastIndex) {
                        // In between
                        print("In between")
                        // Check past activities
                        if (durationInSeconds(startDate: activities[index+1].wrappedEndDate, endDate: startDate) < 0) {
                            isOverlap = true
                            print("Past overlap")
                            overlappingActivity = activities[index+1]
                        }
                        // Check future activities
                        if (durationInSeconds(startDate: endDate, endDate: activities[index-1].wrappedStartDate) < 0) {
                            isOverlap = true
                            print("Future overlap")
                            overlappingActivity = activities[index-1]
                        }
                    } else if (index == 0) {
                        print("No future activities")
                        // Check past activities
                        if (durationInSeconds(startDate: activities[index+1].wrappedEndDate, endDate: startDate) < 0) {
                            isOverlap = true
                            print("Past overlap")
                            overlappingActivity = activities[index+1]
                        }
                    } else if (index == lastIndex) {
                        print("No past activities")
                        // Check future activities
                        if (durationInSeconds(startDate: endDate, endDate: activities[index-1].wrappedStartDate) < 0) {
                            isOverlap = true
                            print("Future overlap")
                            overlappingActivity = activities[index-1]
                        }
                    }

                    if (isOverlap) {
                        DataController().editActivity(activity: activity, name: originalName, selectedCategory: originalCategory, startDate: originalStartDate, endDate: originalEndDate, context: moc)
                        print("Is overlapping")
                    } else {
                        dismiss()
                    }
                } label: {
                    HStack {
                        Spacer()
                        Label("Edit Activity", systemImage: "pencil")
                            .foregroundStyle(.white)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                }
                .disabled(disableEdit)
                .listRowBackground(disableEdit ? Color.gray : Color.yellow)
            }
            
            // Delete activity button
            Button {
                moc.delete(activity)
                DataController().deleteActivity(activity: activity, context: moc)
                dismiss()
            } label: {
                HStack {
                    Spacer()
                    Label("Delete Activity", systemImage: "trash.fill")
                        .foregroundStyle(.white)
                        .fontWeight(.semibold)
                    Spacer()
                }
            }
            .listRowBackground(Color.red)
        }
        .onAppear {
            selectedCategory = activity.category
            name = activity.wrappedName
            startDate = activity.wrappedStartDate
            endDate = activity.wrappedEndDate
        }
        .alert("Time Overlap", isPresented: $isOverlap) {
            
        } message: {
            if (overlappingActivity?.hasName ?? false) {
                Text("Overlaps with \"\(overlappingActivity?.wrappedName ?? "Unknown activity")\" from \(overlappingActivity?.category?.wrappedName ?? "Unknown category")")
            } else {
                Text("Overlaps with an activity from \(overlappingActivity?.category?.wrappedName ?? "Unknown category")")
            }
        }
    }
}
