//
//  CurrentEventView.swift
//  LifeTime
//
//  Created by Mac-aroni on 9/2/23.
//

import SwiftUI

struct CurrentEventView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.startDate, order: .reverse)]) var events: FetchedResults<Event>
    
    let plusButtonAction: ()->Void
    
    var body: some View {
        if (events.isEmpty || events[0].ended == true) {
            // No event in progress
            Section("Current Event") {
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
            // Event in progress
            Section("Current Event") {
                HStack {
                    VStack(alignment: .leading) {
                        Text(events[0].category?.wrappedName ?? "Unknown Name (Category DNE)")
                            .font(.title3)
                            .bold()
                        Text(events[0].hasName ? events[0].wrappedName : " ")
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        Text(events[0].wrappedStartDate, style: .timer)
                            .font(.largeTitle)
                        
                        HStack(spacing: 0) {
                            Text("Started at ")
                            Text(events[0].wrappedStartDate, style: .time)
                        }
                    }
                }
            }
            
            Section {
                Button {
                    events[0].ended = true
                    events[0].endDate = Date()
                    events[0].category?.totalTime += Int32(Date().timeIntervalSince(events[0].wrappedStartDate))
                    
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

struct CurrentEventView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentEventView(plusButtonAction: {})
    }
}
