//
//  AddEventView.swift
//  LifeTime
//
//  Created by Mac-aroni on 8/18/23.
//

import SwiftUI

struct AddEventView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var category: String = ""
    @State private var name: String = ""
    @State private var startDate: Date = Date()
    @State private var endDate: Date = Date()
    
    let categories: [String] = ["Entertainment", "Education", "Sleep", "Eating", "Transportation"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Category", selection: $category) {
                        Text("").tag("")
                        ForEach(categories, id: \.self) {
                            Text($0)
                        }
                    }
                    TextField("Name of event", text: $name)
                }
                
                Section {
                    Button("Save") {
                        let newEvent = Event(context: moc)
                        newEvent.id = UUID()
                        newEvent.category = category
                        newEvent.name = name
                        newEvent.startDate = Date()
                        newEvent.endDate = Date()
                        
                        try? moc.save()
                        dismiss()
                    }
                }
            }
            .navigationTitle("Add Event")
        }
    }
}

struct AddEventView_Previews: PreviewProvider {
    static var previews: some View {
        AddEventView()
    }
}
