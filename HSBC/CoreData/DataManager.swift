//
//  CoreDataManager.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 19/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

class DataManager {

    static let shared = DataManager()
    private let stack: CoreDataStack
    
    init() {
        stack = CoreDataStack()
    }
    
    public func getCitiesList(completion: @escaping ([CityModel]?) -> ()) {
        stack.getCitiesList(completion: { list in
            completion(list)
        })
    }
    
    public func save(cities: [CityModel]) {
        stack.save(cities)
    }
    
    public func update(city: CityModel) {
        stack.update(city)
    }
    
    public func saveContext() { 
        stack.saveContext()
    }
    
    deinit {
        saveContext()
    }
}
