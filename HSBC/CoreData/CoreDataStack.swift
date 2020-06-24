//
//  CoreDataStack.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 19/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import CoreData
import UIKit

protocol CoreDataStackManager {
    func contextHasChanged()
}

final class CoreDataStack: NSObject {
    
    private var privateContext: NSManagedObjectContext?
    public var manager: CoreDataStackManager?
    
    override init() {
        super.init()
        privateContext = persistentContainer.newBackgroundContext()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(contexHasChanged),
                                               name: NSNotification.Name.NSManagedObjectContextObjectsDidChange,
                                               object: privateContext)
    }
    
    @objc func contexHasChanged() {
        manager?.contextHasChanged()
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "HSBC")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    public func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    public func save(_ cities: [CityModel]) {
        guard let context = privateContext else { return }
        for city in cities {
            let predicate = NSPredicate(format: "id = %d", city.id)
            getEntity(predicate: predicate, completion: { (data: City?) in
                if let cityEntity = data {
                    cityEntity.update(from: city)
                } else {
                    let cityEntity = City(context: context, model: city)
                    context.insert(cityEntity)
                }
            })
        }
        self.savePrivateContext()
    }
    
    public func update(_ city: CityModel) {
        guard let context = privateContext else { return }
        let predicate = NSPredicate(format: "id = %d", city.id)
        
        getEntity(predicate: predicate, completion: { (data: City?) in
            guard let entity = data else { return }
            guard let geo = city.geolocation else { return }
            
            let geolocation = Geolocation(context: context, longitude: geo.longitude, latitude: geo.latidute)
            context.insert(geolocation)
            entity.update(from: city)
            entity.geolocation = geolocation
            
            self.savePrivateContext()
        })
    }
    
    public func getCitiesList(completion: @escaping ([CityModel]?) -> Void) {
        getEntieties(completion: { (data: [City]?) in
            completion(data?.map({ $0.model }))
        })
    }
    
    private func getEntieties<T: NSManagedObject>(completion: @escaping ([T]?) -> ()){
        let fetchRequest = NSFetchRequest<T>(entityName: entityName(forObject: T.self))
        do {
            if let data = try privateContext?.fetch(fetchRequest) {
                guard data.count != 0 else {
                    completion(nil)
                    return
                }
                completion(data)
            }
        } catch {
            print(error)
            completion(nil)
        }
    }
    
    private func getEntity<T: NSManagedObject>(predicate: NSPredicate?, completion: @escaping (T?) -> ()){
        let fetchRequest = NSFetchRequest<T>(entityName: entityName(forObject: T.self))
        fetchRequest.predicate = predicate
        do {
            let data = try privateContext?.fetch(fetchRequest).first
            completion(data)
        } catch {
            print(error)
            completion(nil)
        }
    }
    
    private func entityName<T: NSManagedObject>(forObject obj: T.Type) -> String {
        switch obj {
        case is City.Type:
            return "City"
        default:
            return ""
        }
    }
    
    public func savePrivateContext() {
        privateContext?.perform {
            do {
                try self.privateContext?.save()
            } catch {
                // TODO: Handle
            }
        }
    }
}

