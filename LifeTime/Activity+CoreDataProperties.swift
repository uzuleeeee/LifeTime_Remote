//
//  Activity+CoreDataProperties.swift
//  LifeTime
//
//  Created by Mac-aroni on 8/27/23.
//
//

import Foundation
import CoreData


extension Activity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Activity> {
        return NSFetchRequest<Activity>(entityName: "Activity")
    }

    @NSManaged public var endDate: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var startDate: Date?
    @NSManaged public var ended: Bool
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

extension Activity : Identifiable {

}
