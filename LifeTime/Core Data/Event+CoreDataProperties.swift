//
//  Event+CoreDataProperties.swift
//  LifeTime
//
//  Created by Mac-aroni on 8/19/23.
//
//

import Foundation
import CoreData


extension Event {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Event> {
        return NSFetchRequest<Event>(entityName: "Event")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var category: String?
    @NSManaged public var name: String?
    @NSManaged public var startDate: Date?
    @NSManaged public var endDate: Date?
    
    public var wrappedCategory: String {
        category ?? "Unknown Category"
    }
    
    public var wrappedName: String {
        name ?? "Unknown Name"
    }

    public var wrappedStartDate: Date {
        startDate ?? Date(timeIntervalSinceReferenceDate: 0)
    }
    
    public var wrappedEndDate: Date {
        endDate ?? Date(timeIntervalSinceReferenceDate: 0)
    }
}

extension Event : Identifiable {

}
