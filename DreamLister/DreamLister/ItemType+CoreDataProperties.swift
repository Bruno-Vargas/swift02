//
//  ItemType+CoreDataProperties.swift
//  DreamLister
//
//  Created by Bruno Vargas Versignassi de Carvalho on 17/04/17.
//  Copyright © 2017 Bruno Vargas Versignassi de Carvalho. All rights reserved.
//

import Foundation
import CoreData


extension ItemType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemType> {
        return NSFetchRequest<ItemType>(entityName: "ItemType");
    }

    @NSManaged public var type: String?
    @NSManaged public var toItem: Item?

}
