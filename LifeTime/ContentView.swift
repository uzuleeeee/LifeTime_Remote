//
//  ContentView.swift
//  LifeTime
//
//  Created by Mac-aroni on 8/18/23.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var events: FetchedResults<Event>
    
    var body: some View {
        TabView {
            RecordView()
                .tabItem {
                    Label("Record", systemImage: "timer")
                }
            Text("Analyze")
                .tabItem {
                    Label("Analyze", systemImage: "chart.line.uptrend.xyaxis")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
