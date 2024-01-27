//
//  AnalyzeView.swift
//  LifeTime
//
//  Created by Mac-aroni on 8/19/23.
//

import SwiftUI
import Charts

struct AnalyzeView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.startDate, order: .reverse)]) var activities: FetchedResults<Activity>
    @FetchRequest(sortDescriptors: [SortDescriptor(\.totalTime, order: .reverse)]) var categories: FetchedResults<Category>
    
    var body: some View {
        VStack {
            Chart {
                ForEach(categories) { category in
                    BarMark(
                        x: .value("Time", category.totalTime),
                        y: .value("Name", category.wrappedName)
                    )
                    .annotation(position: .trailing) {
                        Text(formatSeconds(seconds: category.totalTime))
                        Text("\(category.totalTime == 0 ? "" : String(category.totalTime))")
                    }
                    .foregroundStyle(Color.blue.gradient)
                    .cornerRadius(5)
                }
            }
            .chartXAxis(.hidden)
            .chartYAxis {
                AxisMarks { _ in
                    AxisValueLabel()
                }
            }
            .padding()
        }
    }
}

struct AnalyzeView_Previews: PreviewProvider {
    static var previews: some View {
        AnalyzeView()
    }
}
