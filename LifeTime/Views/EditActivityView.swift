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
    
    @State var activity: Activity
    
    @State private var selectedCategory: Category?
    @State private var name: String = ""
    @State private var startDate: Date = Date()
    @State private var endDate: Date = Date()
    
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
                    DataController().editActivity(activity: activity, name: name, selectedCategory: selectedCategory, startDate: startDate, endDate: endDate, context: moc)
                    dismiss()
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
    }
}
