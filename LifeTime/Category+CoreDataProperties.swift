//
//  Category+CoreDataProperties.swift
//  LifeTime
//
//  Created by Mac-aroni on 8/27/23.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var name: String?
    @NSManaged public var symbolName: String?
    @NSManaged public var totalTime: Int32
    @NSManaged public var event: NSSet?

    public var wrappedName: String {
        name ?? "Unknown Name"
    }
    
    public var wrappedSymbolName: String {
        symbolName ?? "Unknown Symbol"
    }
    
    public var eventArray: [Event] {
        let set = event as? Set<Event> ?? []
        
        return set.sorted {
            $0.wrappedStartDate < $1.wrappedStartDate
        }
    }
    
    /*
    public var totalTime: Int {
        Int(eventArray.reduce(0, { $0 + $1.wrappedEndDate.timeIntervalSince($1.wrappedStartDate) }))
    }
     */
}

// MARK: Generated accessors for event
extension Category {

    @objc(addEventObject:)
    @NSManaged public func addToEvent(_ value: Event)

    @objc(removeEventObject:)
    @NSManaged public func removeFromEvent(_ value: Event)

    @objc(addEvent:)
    @NSManaged public func addToEvent(_ values: NSSet)

    @objc(removeEvent:)
    @NSManaged public func removeFromEvent(_ values: NSSet)

}

extension Category : Identifiable {

}
