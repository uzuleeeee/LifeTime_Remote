//
//  CategoryView.swift
//  LifeTime
//
//  Created by Mac-aroni on 1/26/24.
//

import SwiftUI

struct CategoryView: View {
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var categories: FetchedResults<Category>
    
    let gridRow = [
        GridItem(.flexible(minimum: 80, maximum: 100)),
        GridItem(.flexible(minimum: 80, maximum: 100)),
        GridItem(.flexible(minimum: 80, maximum: 100))
    ]
    
    let sfSymbols = ["figure.run", "brain.head.profile", "person.line.dotted.person.fill", "cart", "bed.double", "cross.case", "frying.pan.fill", "toilet.fill", "fork.knife", "location", "theatermasks", "book", "headphones", "graduationcap", "bag"]
    
    var body: some View {
        Section("Categories") {
            ScrollView(.horizontal) {
                LazyHGrid(rows: gridRow, spacing: 20) {
                    ForEach(sfSymbols, id: \.self) { sfSymbol in
                        VStack {
                            Image(systemName: sfSymbol)
                                .font(.title)
                            Text("\(sfSymbol)")
                        }
                        .foregroundColor(Color(red: 0.5, green: 0.5, blue: 0.5))
                        .frame(width: 50, height: 50)
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    CategoryView()
}
