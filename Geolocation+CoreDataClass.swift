//
//  Geolocation+CoreDataClass.swift
//  HSBC
//
//  Created by Michał Krupa on 22/06/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Geolocation)
public class Geolocation: NSManagedObject {
    
    init(context: NSManagedObjectContext, longitude: Double, latitude: Double) {
        let entity = NSEntityDescription.entity(forEntityName: "Geolocation", in: context)!
        super.init(entity: entity, insertInto: context)
        self.longitude = longitude
        self.latitude = latitude
    }
    
    override public init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    public var model: GeolocationProtocol {
        return GeolocationProtocol(longitude: self.longitude, latidute: self.latitude)
    }
}

