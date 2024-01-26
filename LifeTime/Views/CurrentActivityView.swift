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
                Button(action: plusButtonAction) {
                    HStack {
                        Spacer()
                        Image(systemName: "plus")
                            .font(.title)
                            .fontWeight(.semibold)
                            .padding()
                            .foregroundColor(.white)
                        Spacer()
                    }
                }
                .listRowBackground(Color.blue)
            }
        } else {
            // Activity in progress
            Section("Current Activity") {
                HStack {
                    VStack(alignment: .leading) {
                        Text(activities[0].category?.wrappedName ?? "Unknown Name (Category DNE)")
                            .font(.title3)
                            .bold()
                        Text(activities[0].hasName ? activities[0].wrappedName : " ")
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        Text(activities[0].wrappedStartDate, style: .timer)
                            .font(.largeTitle)
                        
                        HStack(spacing: 0) {
                            Text("Started at ")
                            Text(activities[0].wrappedStartDate, style: .time)
                        }
                    }
                }
            }
            
            Section {
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
                        Image(systemName: "xmark")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
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
