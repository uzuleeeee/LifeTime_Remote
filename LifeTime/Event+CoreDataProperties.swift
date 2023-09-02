//
//  Event+CoreDataProperties.swift
//  LifeTime
//
//  Created by Mac-aroni on 8/27/23.
//
//

import Foundation
import CoreData


extension Event {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Event> {
        return NSFetchRequest<Event>(entityName: "Event")
    }

    @NSManaged public var endDate: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var startDate: Date?
    @NSManaged public var category: Category?

    public var wrappedName: String {
        name ?? "Unknown Name"
    }

    public var wrappedStartDate: Date {
        startDate ?? Date(timeIntervalSinceReferenceDate: 0)
    }
    
    public var wrappedEndDate: Date {
        endDate ?? Date(timeIntervalSinceReferenceDate: 0)
    }
    
    public var hasName: Bool {
        wrappedName.count != 0
    }
}

extension Event : Identifiable {

}
