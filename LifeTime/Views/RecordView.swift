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
