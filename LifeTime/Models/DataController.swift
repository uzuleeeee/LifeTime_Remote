//
//  DataController.swift
//  LifeTime
//
//  Created by Mac-aroni on 8/18/23.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "LifeTime")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
                return
            }
            
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        }
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            print("Error saving data: \(error.localizedDescription)")
        }
    }
    
    func addActivity(name: String, selectedCategory: Category?, context: NSManagedObjectContext) {
        let newActivity = Activity(context: context)
        newActivity.id = UUID()
        newActivity.category = selectedCategory
        newActivity.category?.name = selectedCategory?.wrappedName
        newActivity.name = name
        newActivity.startDate = Date()
        newActivity.endDate = Date()
        
        save(context: context)
    }
    
    func addCategory(name: String, symbolName: String, context: NSManagedObjectContext) {
        let newCategory = Category(context: context)
        newCategory.name = name
        newCategory.symbolName = symbolName
        
        save(context: context)
    }
    
    func addDefaultCategories(context: NSManagedObjectContext) {
        // Check if data already exists
        let fetchRequest = Category.fetchRequest()
        
        do {
            let count = try context.count(for: fetchRequest)
            
            if count == 0 {
                // No data exists, insert default data
                insertDefaultCategories(context: context)
            }
        } catch {
            print("Error counting categories: \(error.localizedDescription)")
        }
    }
    
    private func insertDefaultCategories(context: NSManagedObjectContext) {
        addCategory(name: "Sleep", symbolName: "bed.double.fill", context: context)
        addCategory(name: "Work", symbolName: "bag.fill", context: context)
        addCategory(name: "Leisure", symbolName: "theatermasks.fill", context: context)
        addCategory(name: "Housework", symbolName: "house.fill", context: context)
        addCategory(name: "Social", symbolName: "person.2.fill", context: context)
        addCategory(name: "Eating", symbolName: "fork.knife", context: context)
        addCategory(name: "Travel", symbolName: "location.fill", context: context)
        addCategory(name: "Education", symbolName: "book.fill", context: context)
        addCategory(name: "Health", symbolName: "heart.circle.fill", context: context)
        addCategory(name: "Personal", symbolName: "person.circle", context: context)
        
        save(context: context)
    }
    
    /*
    func editActivity(activity: Activity, name: String, selectedCategory: Category?, startDate: Date, endDate: Date, context: NSManagedObjectContext) -> Bool {
        // Check for overlap
        let originalStartDate = activity.startDate
        let originalEndDate = activity.endDate
        activity.startDate = startDate
        activity.endDate = endDate
        
        save(context: context)
        
        @FetchRequest(sortDescriptors: [SortDescriptor(\.startDate, order: .reverse)]) var activities: FetchedResults<Activity>
        
        let index = activities.firstIndex(of: activity) ?? 0
        let lastIndex = activities.count - 1
        var isOverlapping = false
        
        if (index > 0 && index < lastIndex) {
            // In between
            
            // Check left
            if (durationInSeconds(startDate: activities[index-1].wrappedEndDate, endDate: startDate) < 0) {
                isOverlapping = true
            }
            // Check right
            if (durationInSeconds(startDate: endDate, endDate: activities[index+1].wrappedStartDate) < 0) {
                isOverlapping = true
            }
        } else if (index == 0) {
            // No smaller
            
            // Check right
            if (durationInSeconds(startDate: endDate, endDate: activities[index+1].wrappedStartDate) < 0) {
                isOverlapping = true
            }
        } else if (index == lastIndex) {
            // No larger
            
            // Check left
            if (durationInSeconds(startDate: activities[index-1].wrappedEndDate, endDate: startDate) < 0) {
                isOverlapping = true
            }
        }
        
        if (isOverlapping) {
            print("Is overlapping. Reverting changes.")
            activity.startDate = originalStartDate
            activity.endDate = originalEndDate
            
            save(context: context)
            
            return false
        }
        
        activity.category?.totalTime -= activity.durationInSeconds
        
        activity.name = name
        activity.category = selectedCategory
        activity.startDate = startDate
        activity.endDate = endDate
        
        activity.category?.totalTime += Int32(activity.wrappedEndDate.timeIntervalSince(activity.wrappedStartDate))
        
        save(context: context)
        
        return true
    }
    */
    
    func editActivity(activity: Activity, name: String, selectedCategory: Category?, startDate: Date, endDate: Date, context: NSManagedObjectContext) {
        activity.category?.totalTime -= activity.durationInSeconds
        
        activity.name = name
        activity.category = selectedCategory
        activity.startDate = startDate
        activity.endDate = endDate
        
        activity.category?.totalTime += Int32(activity.wrappedEndDate.timeIntervalSince(activity.wrappedStartDate))
        
        save(context: context)
    }
    
    func deleteActivity(activity: Activity, context: NSManagedObjectContext) {
        activity.category?.totalTime -= Int32(activity.wrappedEndDate.timeIntervalSince(activity.wrappedStartDate))
        
        if (activity.category?.totalTime ?? 0 < 0) {
            activity.category?.totalTime = 0
        }
        
        save(context: context)
    }
}
