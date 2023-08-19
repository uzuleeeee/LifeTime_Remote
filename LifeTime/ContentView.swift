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
    
    @State private var isShowingStartEventView: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach (events) { event in
                    EventView(event: event)
                    
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isShowingStartEventView.toggle()
                    } label: {
                        Label("Add Event", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $isShowingStartEventView) {
                StartEventView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
