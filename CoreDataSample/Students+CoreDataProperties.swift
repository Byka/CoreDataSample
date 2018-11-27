//
//  Students+CoreDataProperties.swift
//  CoreDataSample
//
//  Created by sbyka on 27/11/18.
//  Copyright © 2018 sbyka. All rights reserved.
//
//

import Foundation
import CoreData


extension Students {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Students> {
        return NSFetchRequest<Students>(entityName: "Students")
    }

    @NSManaged public var name: String?
    @NSManaged public var phonenumber: Int32

}
