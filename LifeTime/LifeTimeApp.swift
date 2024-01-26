//
//  LifeTimeApp.swift
//  LifeTime
//
//  Created by Mac-aroni on 8/18/23.
//

import SwiftUI

@main
struct LifeTimeApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .onAppear {
                    DataController().addDefaultCategories(context: dataController.container.viewContext)
                }
        }
    }
}
