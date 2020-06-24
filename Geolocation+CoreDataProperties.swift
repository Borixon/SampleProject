//
//  Geolocation+CoreDataProperties.swift
//  HSBC
//
//  Created by Michał Krupa on 22/06/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//
//

import Foundation
import CoreData


extension Geolocation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Geolocation> {
        return NSFetchRequest<Geolocation>(entityName: "Geolocation")
    }

    @NSManaged public var longitude: Double
    @NSManaged public var latitude: Double
    @NSManaged public var city: City?

}
