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
    @FetchRequest(sortDescriptors: [SortDescriptor(\.startDate, order: .reverse)]) var events: FetchedResults<Event>
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
                        switch category.totalTime {
                        case 0:
                            Text("")
                        case 1...60:
                            Text("\(category.totalTime)s")
                        case 61...3600:
                            Text("\(category.totalTime / 60)m")
                        case 3601...2628000:
                            Text("\(category.totalTime / 3600)d")
                        case 2628001...31540000:
                            Text("\(category.totalTime / 2628000)m")
                        default:
                            Text("\(category.totalTime / 31540000)y")
                        }
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
