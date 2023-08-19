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
            Text((event.startDate ?? Date()).formatted(date: .abbreviated, time: .shortened))
            Text((event.endDate ?? Date()).formatted(date: .abbreviated, time: .shortened))
        }
    }
}

struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        EventView(event: Event())
    }
}
