//
//  ActivityView.swift
//  LifeTime
//
//  Created by Mac-aroni on 8/19/23.
//

import SwiftUI

struct ActivityView: View {
    var activity: Activity
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(activity.category?.wrappedName ?? "Unknown Name (Category DNE)")
                .font(.headline)
            if (activity.hasName) {
                Text(activity.wrappedName)
            }
            Text("Start time:")
            Text(activity.wrappedStartDate.formatted(date: .abbreviated, time: .shortened))
                .padding(.leading)
            Text("End time:")
            Text(activity.wrappedEndDate.formatted(date: .abbreviated, time: .shortened))
                .padding(.leading)
        }
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView(activity: Activity())
    }
}
