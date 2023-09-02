//
//  RecordView.swift
//  LifeTime
//
//  Created by Mac-aroni on 8/19/23.
//

import SwiftUI

struct RecordView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var categories: FetchedResults<Category>
    
    @State private var isShowingStartEventView: Bool = false
    
    var body: some View {
        Form {
            Section("Current Event") {
                Button {
                    isShowingStartEventView.toggle()
                } label: {
                    HStack {
                        Spacer()
                        Image(systemName: "plus")
                            .font(.title)
                            .fontWeight(.semibold)
                            .padding()
                            .foregroundColor(.white)
                        Spacer()
                    }
                }
            }
            .listRowBackground(Color.blue)
            
            Section("Categories") {
                List {
                    ForEach(categories, id: \.self) { category in
                        Text(category.wrappedName)
                    }
                }
            }
        }
        .sheet(isPresented: $isShowingStartEventView) {
            StartEventView()
        }
        .onAppear {
            let newCategory = Category(context: moc)
            newCategory.name = "Entertainment"
            
            let newCategory2 = Category(context: moc)
            newCategory2.name = "Study"
            
            let newCategory3 = Category(context: moc)
            newCategory3.name = "Sleep"
            
            if moc.hasChanges {
                try? moc.save()
            }
        }
    }
}

struct RecordView_Previews: PreviewProvider {
    static var previews: some View {
        RecordView()
    }
}
