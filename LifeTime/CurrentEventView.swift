//
//  CurrentEventView.swift
//  LifeTime
//
//  Created by Mac-aroni on 8/19/23.
//

import SwiftUI

struct CurrentEventView: View {
    var event: Event
    
    var body: some View {
        EventView(event: event)
    }
}

struct CurrentEventView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentEventView(event: Event())
    }
}
