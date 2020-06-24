//
//  City+CoreDataClass.swift
//  HSBC
//
//  Created by Michał Krupa on 23/06/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//
//

import Foundation
import CoreData

@objc(City)
public class City: NSManagedObject {
    
    init(context: NSManagedObjectContext, model: CityModel) {
        let entity = NSEntityDescription.entity(forEntityName: "City", in: context)!
        super.init(entity: entity, insertInto: context)
        self.cityDescription = model.cityDescription
        self.detailText = model.detailText
        self.didCheckDetails = model.didCheckDetails
        self.id = model.id
        self.imageLink = model.imageURL
        self.isFavourite = model.isFavourite
        self.name = model.name
        self.rating = model.rating ?? 0
        self.population = model.population ?? 0
    }
    
    override public init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    public var model: CityModel {
        return CityModel(self)
    }
    
    public func update(from model: CityModel) {
        self.cityDescription = model.cityDescription
        self.detailText = model.detailText
        self.didCheckDetails = model.didCheckDetails
        self.id = model.id
        self.imageLink = model.imageURL
        self.isFavourite = model.isFavourite
        self.name = model.name
        self.rating = model.rating ?? 0
        self.population = model.population ?? 0
    }
}
