//
//  CategoryView.swift
//  LifeTime
//
//  Created by Mac-aroni on 1/26/24.
//

import SwiftUI

struct CategoryView: View {
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var categories: FetchedResults<Category>
    
    let gridColumn = [
        GridItem(.adaptive(minimum: 80))
    ]
    
    var body: some View {
        Section("Categories") {
            List {
                ForEach(categories) { category in
                    NavigationLink {
                        CategoryDetailView(category: category)
                    } label: {
                        VStack {
                            Label(category.wrappedName, systemImage: category.wrappedSymbolName)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    CategoryView()
}
