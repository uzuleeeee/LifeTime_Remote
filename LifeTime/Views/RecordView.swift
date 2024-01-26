//
//  RecordView.swift
//  LifeTime
//
//  Created by Mac-aroni on 8/19/23.
//

import SwiftUI

struct RecordView: View {
    @Environment(\.managedObjectContext) var moc
    
    @State private var isShowingStartActivityView: Bool = false
    
    var body: some View {
        VStack {
            Form {
                CurrentActivityView(plusButtonAction: showStartActivityView)
                CategoryView()
            }
            .sheet(isPresented: $isShowingStartActivityView) {
                StartActivityView()
            }
        }
    }
    
    func showStartActivityView() {
        isShowingStartActivityView = true
    }
}

struct RecordView_Previews: PreviewProvider {
    static var previews: some View {
        RecordView()
    }
}
