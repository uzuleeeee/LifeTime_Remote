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
    @FetchRequest(sortDescriptors: [SortDescriptor(\.totalTime)]) var categories: FetchedResults<Category>
    
    var body: some View {
        VStack {
            Chart {
                ForEach(categories) { category in
                    BarMark(
                        x: .value("Time", category.totalTime),
                        y: .value("Name", category.wrappedName)
                    )
                    .annotation(position: .trailing) {
                        Text("\(category.totalTime == 0 ? "" : String(category.totalTime))")
                    }
                }
            }
            .chartXAxis(.hidden)
            .chartYAxis {
                AxisMarks { _ in
                    AxisValueLabel()
                }
            }
            .padding()
            /*
            List {
                ForEach(categories) { category in
                    Section(category.wrappedName) {
                        ForEach(category.eventArray) { event in
                            HStack {
                                Text(event.wrappedName)
                                Text(event.ended ? "ended" : "not ended")
                                Text(event.wrappedStartDate, style: .time)
                                Text(event.wrappedEndDate, style: .time)
                            }
                        }
                    }
                }
                /*
                 ForEach (events) { event in
                 EventView(event: event)
                 }
                 */
            }
             */
        }
        /*
        .onAppear {
            if moc.hasChanges {
                try? moc.save()
            }
        }
         */
    }
}

struct AnalyzeView_Previews: PreviewProvider {
    static var previews: some View {
        AnalyzeView()
    }
}
