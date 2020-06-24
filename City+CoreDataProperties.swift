//
//  City+CoreDataProperties.swift
//  HSBC
//
//  Created by Michał Krupa on 23/06/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//
//

import Foundation
import CoreData


extension City {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<City> {
        return NSFetchRequest<City>(entityName: "City")
    }

    @NSManaged public var cityDescription: String?
    @NSManaged public var detailText: String?
    @NSManaged public var didCheckDetails: Bool
    @NSManaged public var id: Int32
    @NSManaged public var imageLink: String
    @NSManaged public var isFavourite: Bool
    @NSManaged public var name: String
    @NSManaged public var population: Int64
    @NSManaged public var rating: Float
    @NSManaged public var geolocation: Geolocation?

}
