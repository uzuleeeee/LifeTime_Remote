//
//  CategoryDetailView.swift
//  LifeTime
//
//  Created by Mac-aroni on 1/27/24.
//

import SwiftUI

struct CategoryDetailView: View {
    @State var category: Category
    @FetchRequest(sortDescriptors: [SortDescriptor(\.startDate, order: .reverse)]) private var activities: FetchedResults<Activity>
    
    var body: some View {
        List {
            ForEach(activities) { activity in
                VStack(alignment: .leading) {
                    if (activity.hasName) {
                        Text(activity.name ?? "Unknonw activity")
                            .font(.headline)
                            .fontWeight(.medium)
                    }
                    HStack {
                        Text(String(activity.durationInSeconds))
                        Spacer()
                        VStack(alignment: .trailing) {
                            HStack {
                                Text("From: ")
                                Text(activity.wrappedStartDate, style: .time)
                            }
                            HStack {
                                Text("To: ")
                                Text(activity.wrappedEndDate, style: .time)
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
