//
//  Item+CoreDataProperties.swift
//  DreamLister
//
//  Created by Bruno Vargas Versignassi de Carvalho on 17/04/17.
//  Copyright © 2017 Bruno Vargas Versignassi de Carvalho. All rights reserved.
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item");
    }

    @NSManaged public var created: NSDate?
    @NSManaged public var deatails: String?
    @NSManaged public var title: String?
    @NSManaged public var price: Double
    @NSManaged public var toImage: Image?
    @NSManaged public var toItemType: ItemType?
    @NSManaged public var toStore: Store?

}
