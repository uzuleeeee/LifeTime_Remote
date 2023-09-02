//
//  StartEventView.swift
//  LifeTime
//
//  Created by Mac-aroni on 8/18/23.
//

import SwiftUI

struct StartEventView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var categories: FetchedResults<Category>
    
    @Environment(\.dismiss) var dismiss
    
    @State private var selectedCategory: Category?
    @State private var name: String = ""
    @State private var startDate: Date = Date()
    @State private var endDate: Date = Date()

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Category", selection: $selectedCategory) {
                        ForEach(categories) { category in
                            Text(category.wrappedName)
                                .tag(Optional(category))
                        }
                        .onAppear {
                            selectedCategory = categories[0]
                        }
                    }
                    TextField("Name of event", text: $name)
                }
                
                Section {
                    Button("Start") {
                        let newEvent = Event(context: moc)
                        newEvent.id = UUID()
                        newEvent.category = Category(context: moc)
                        newEvent.category?.name = selectedCategory?.wrappedName
                        newEvent.name = name
                        newEvent.startDate = Date()
                        newEvent.endDate = Date()
                        
                        if moc.hasChanges {
                            try? moc.save()
                            dismiss()
                        }
                    }
                    .disabled(selectedCategory == nil)
                }
            }
            .navigationTitle("New Event")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct AddEventView_Previews: PreviewProvider {
    static var previews: some View {
        StartEventView()
    }
}
