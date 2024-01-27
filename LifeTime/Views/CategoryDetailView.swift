//
//  CategoryDetailView.swift
//  LifeTime
//
//  Created by Mac-aroni on 1/27/24.
//

import SwiftUI

struct CategoryDetailView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest private var activities: FetchedResults<Activity>
    @State var category: Category

    init(category: Category) {
        self._category = State(initialValue: category)
        _activities = FetchRequest(sortDescriptors: [SortDescriptor(\.startDate, order: .reverse)],
                                   predicate: NSPredicate(format: "category.name == %@", category.wrappedName))
    }
    
    var body: some View {
        List {
            // No data
            if (activities.isEmpty) {
                Text("No data to show")
                    .foregroundColor(.gray)
            } else {
                // Has data
                ForEach(activities) { activity in
                    // Activity ended
                    if (activity.ended) {
                        VStack(alignment: .leading) {
                            // Name
                            if (activity.hasName) {
                                Text(activity.name ?? "Unknown activity")
                                    .font(.caption)
                                    .fontWeight(.regular)
                            }
                            // Time
                            HStack {
                                // Duration
                                Text(formatSeconds(seconds: activity.durationInSeconds))
                                    .font(.title)
                                    .fontWeight(.medium)
                                Spacer()
                                // From ... To ...
                                VStack(alignment: .trailing) {
                                    HStack {
                                        Text("To: ")
                                        Text(activity.wrappedEndDate, style: .time)
                                    }
                                    HStack {
                                        Text("From: ")
                                        Text(activity.wrappedStartDate, style: .time)
                                    }
                                    
                                }
                            }
                        }
                    } else {
                        // Activity in progress 
                        VStack(alignment: .leading) {
                            // Name
                            if (activity.hasName) {
                                Text(activity.name ?? "Unknown activity")
                                    .font(.caption)
                                    .fontWeight(.regular)
                            }
                            HStack {
                                // In progress text
                                Text("In progress")
                                    .font(.title3)
                                    .fontWeight(.medium)
                                Spacer()
                                // From ... To ...
                                VStack(alignment: .trailing) {
                                    HStack {
                                        Text("From: ")
                                        Text(activity.wrappedStartDate, style: .time)
                                    }
                                }
                            }
                        }
                    }
                }
                .onDelete(perform: deleteActivity)
            }
        }
        .navigationTitle(category.wrappedName)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                EditButton()
            }
        }
    }
    
    private func deleteActivity(offsets: IndexSet) {
        withAnimation {
            offsets.map { activities[$0] }.forEach(moc.delete)
            
            DataController().save(context: moc)
        }
    }
}
