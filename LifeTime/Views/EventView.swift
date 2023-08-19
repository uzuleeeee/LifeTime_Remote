//
//  EventView.swift
//  LifeTime
//
//  Created by Mac-aroni on 8/19/23.
//

import SwiftUI

struct EventView: View {
    var event: Event
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(event.wrappedCategory)
                .font(.headline)
            if (event.hasName) {
                Text(event.wrappedName)
            }
            Text("Start time:")
            Text(event.wrappedStartDate.formatted(date: .abbreviated, time: .shortened))
                .padding(.leading)
            Text("End time:")
            Text(event.wrappedEndDate.formatted(date: .abbreviated, time: .shortened))
                .padding(.leading)
        }
    }
}

struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        EventView(event: Event())
    }
}
