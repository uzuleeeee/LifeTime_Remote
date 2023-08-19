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
        }
        .sheet(isPresented: $isShowingStartEventView) {
            StartEventView()
        }
    }
}

struct RecordView_Previews: PreviewProvider {
    static var previews: some View {
        RecordView()
    }
}
