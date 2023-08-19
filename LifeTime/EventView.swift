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
            Text(event.category ?? "Category")
                .font(.headline)
            if (event.name?.count != 0) {
                Text(event.name ?? "Name")
            }
            Text("Start time:")
            Text((event.startDate ?? Date()).formatted(date: .abbreviated, time: .shortened))
                .padding(.leading)
            Text("End time:")
            Text((event.endDate ?? Date()).formatted(date: .abbreviated, time: .shortened))
                .padding(.leading)
        }
    }
}

struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        EventView(event: Event())
    }
}
