//
//  StartActivityView.swift
//  LifeTime
//
//  Created by Mac-aroni on 8/18/23.
//

import SwiftUI

struct StartActivityView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var categories: FetchedResults<Category>
    
    @State private var selectedCategory: Category?
    @State private var name: String = ""
    @State private var startDate: Date = Date()
    @State private var endDate: Date = Date()

    var body: some View {
        Group {
            Picker("Category", selection: $selectedCategory) {
                ForEach(categories) { category in
                    Text(category.wrappedName)
                        .tag(Optional(category))
                }
                .onAppear {
                    selectedCategory = categories[0]
                }
            }
            TextField("Name of activity", text: $name)
            
            Button {
                DataController().addActivity(name: name, selectedCategory: selectedCategory, context: moc)
                name = ""
            } label: {
                HStack {
                    Spacer()
                    Label("Start Activity", systemImage: "play.fill")
                        .foregroundStyle(.white)
                        .fontWeight(.semibold)
                    Spacer()
                }
            }
            .disabled(selectedCategory == nil)
            .listRowBackground(Color.blue)
        }
    }
}

struct AddActivityView_Previews: PreviewProvider {
    static var previews: some View {
        StartActivityView()
    }
}
