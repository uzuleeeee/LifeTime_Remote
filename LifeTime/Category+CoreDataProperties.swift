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
    @NSManaged public var activity: NSSet?

    public var wrappedName: String {
        name ?? "Unknown Name"
    }
    
    public var wrappedSymbolName: String {
        symbolName ?? "Unknown Symbol"
    }
    
    public var activityArray: [Activity] {
        let set = activity as? Set<Activity> ?? []
        
        return set.sorted {
            $0.wrappedStartDate < $1.wrappedStartDate
        }
    }
}

// MARK: Generated accessors for activity
extension Category {

    @objc(addActivityObject:)
    @NSManaged public func addToActivity(_ value: Activity)

    @objc(removeActivityObject:)
    @NSManaged public func removeFromActivity(_ value: Activity)

    @objc(addActivity:)
    @NSManaged public func addToActivity(_ values: NSSet)

    @objc(removeActivity:)
    @NSManaged public func removeFromActivity(_ values: NSSet)

}

extension Category : Identifiable {

}
