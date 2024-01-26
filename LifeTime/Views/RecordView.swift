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
            /*
            .onAppear {
                let sleep = Category(context: moc)
                sleep.name = "Sleep"
                sleep.symbolName = "bed.double.fill"
                
                let work = Category(context: moc)
                work.name = "Work"
                work.symbolName = "bag.fill"
                
                let leisure = Category(context: moc)
                leisure.name = "Leisure"
                leisure.symbolName = "theatermasks.fill"
                
                let housework = Category(context: moc)
                housework.name = "House"
                housework.symbolName = "house.fill"
                
                let social = Category(context: moc)
                social.name = "Social"
                social.symbolName = "person.2.fill"
                
                let eating = Category(context: moc)
                eating.name = "Eating"
                eating.symbolName = "fork.knife"
                
                let travel = Category(context: moc)
                travel.name = "Travel"
                travel.symbolName = "location.fill"
                
                let education = Category(context: moc)
                education.name = "Education"
                education.symbolName = "book.fill"
                
                let health = Category(context: moc)
                health.name = "Health"
                health.symbolName = "heart.circle.fill"
                
                let personal = Category(context: moc)
                personal.name = "Personal"
                personal.symbolName = "person.circle"
                
                if moc.hasChanges {
                    try? moc.save()
                }
            }
             */
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
