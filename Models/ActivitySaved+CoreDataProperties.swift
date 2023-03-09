//
//  ActivitySaved+CoreDataProperties.swift
//  IntheKnow1
//
//  Created by mac on 2/23/23.
//
//

import Foundation
import CoreData


extension ActivitySaved {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ActivitySaved> {
        return NSFetchRequest<ActivitySaved>(entityName: "ActivitySaved")
    }

    @NSManaged public var date: Date?
    @NSManaged public var details: String?
    @NSManaged public var location: String?
    @NSManaged public var name: String?
    @NSManaged public var time: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var group: GroupSaved?

}

extension ActivitySaved : Identifiable {

}
