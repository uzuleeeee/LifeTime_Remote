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
        if (events[0].ended == true) {
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
        } else {
            VStack {
                Text(events[0].category?.wrappedName ?? "Unknown Name (Category DNE)")
                
                Button("End Event") {
                    events[0].ended = true
                    
                    if moc.hasChanges {
                        try? moc.save()
                    }
                }  
            }
        }
    }
}

struct CurrentEventView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentEventView(plusButtonAction: {})
    }
}
