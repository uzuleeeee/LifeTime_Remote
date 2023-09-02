//
//  CurrentEventView.swift
//  LifeTime
//
//  Created by Mac-aroni on 9/2/23.
//

import SwiftUI

struct CurrentEventView: View {
    let plusButtonAction: ()->Void
    
    var body: some View {
        Button(action: plusButtonAction) {
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
}

struct CurrentEventView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentEventView(plusButtonAction: {})
    }
}
