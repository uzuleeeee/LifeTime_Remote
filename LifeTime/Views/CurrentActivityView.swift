//
//  CurrentActivityView.swift
//  LifeTime
//
//  Created by Mac-aroni on 9/2/23.
//

import SwiftUI

struct CurrentActivityView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.startDate, order: .reverse)]) var activities: FetchedResults<Activity>
    
    let plusButtonAction: ()->Void
    
    var body: some View {
        if (activities.isEmpty || activities[0].ended == true) {
            // No activity in progress
            Section("Current Activity") {
                StartActivityView()
            }
        } else {
            // Activity in progress
            Section("Current Activity") {
                VStack(spacing: 10) {
                    // Header
                    HStack {
                        Label(activities[0].category?.wrappedName ?? "Unknown category", systemImage: activities[0].category?.wrappedSymbolName ?? "Unknown symbol")
                            .font(.title)
                            .fontWeight(.medium)
                        Spacer()
                        Text(activities[0].wrappedStartDate, style: .timer)
                            .font(.largeTitle)
                    }
                    Divider()
                        .padding(0)
                    // Footer
                    HStack {
                        if (activities[0].hasName) {
                            Text(activities[0].wrappedName)
                        }
                        Spacer()
                        HStack(spacing: 0) {
                            Text("Started at ")
                            Text(activities[0].wrappedStartDate, style: .time)
                        }
                    }
                }
                
                // End button
                Button {
                    activities[0].ended = true
                    activities[0].endDate = Date()
                    activities[0].category?.totalTime += Int32(Date().timeIntervalSince(activities[0].wrappedStartDate))
                    
                    withAnimation {
                        DataController().save(context: moc)
                    }
                } label: {
                    HStack {
                        Spacer()
                        Label("Stop Activity", systemImage: "stop.circle.fill")
                            .foregroundStyle(.white)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                }
                .listRowBackground(Color.red)
            }
        }
    }
}

struct CurrentActivityView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentActivityView(plusButtonAction: {})
    }
}
