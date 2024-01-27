//
//  CategoryDetailView.swift
//  LifeTime
//
//  Created by Mac-aroni on 1/27/24.
//

import SwiftUI

struct CategoryDetailView: View {
    @State var category: Category
    @FetchRequest private var activities: FetchedResults<Activity>

    init(category: Category) {
        self._category = State(initialValue: category)
        _activities = FetchRequest(sortDescriptors: [SortDescriptor(\.startDate, order: .reverse)],
                                   predicate: NSPredicate(format: "category.name == %@", category.wrappedName))
    }
    
    var body: some View {
        List {
            if (activities.isEmpty) {
                Text("No data to show")
                    .foregroundColor(.gray)
            } else {
                ForEach(activities) { activity in
                    if (activity.ended) {
                        VStack(alignment: .leading) {
                            if (activity.hasName) {
                                Text(activity.name ?? "Unknown activity")
                                    .font(.caption)
                                    .fontWeight(.medium)
                            }
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
                    }
                }
            }
        }
        .navigationTitle(category.wrappedName)
        .navigationBarTitleDisplayMode(.inline)
    }
}
