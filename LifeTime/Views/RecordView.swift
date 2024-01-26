//
//  RecordView.swift
//  LifeTime
//
//  Created by Mac-aroni on 8/19/23.
//

import SwiftUI

struct RecordView: View {
    @Environment(\.managedObjectContext) var moc
    
    @State private var isShowingStartEventView: Bool = false
    
    var body: some View {
        VStack {
            Form {
                CurrentEventView(plusButtonAction: showStartEventView)
                CategoryView()
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
    
    func showStartEventView() {
        isShowingStartEventView = true
    }
}

struct RecordView_Previews: PreviewProvider {
    static var previews: some View {
        RecordView()
    }
}
