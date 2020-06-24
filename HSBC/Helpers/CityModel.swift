//
//  MediaModel.swift
//  Preglife
//
//  Created by Michał Krupa on 13/03/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit
import Foundation

public class CityModel {
    
    let id: Int32
    let name: String
    let imageURL: String
    var didCheckDetails: Bool = false
    var isFavourite: Bool = false
    var population: Int64? = nil
    var cityDescription: String? = nil
    var rating: Float? = nil
    var image: UIImage? = nil
    var detailText: String? = nil
    var geolocation: GeolocationProtocol? = nil
    
    init(_ entity: City) {
        self.id = entity.id
        self.name = entity.name
        self.imageURL = entity.imageLink
        self.didCheckDetails = entity.didCheckDetails
        self.isFavourite = entity.isFavourite
        self.population = entity.population
        self.cityDescription = entity.cityDescription
        self.rating = entity.rating
        self.detailText = entity.detailText
        self.geolocation = entity.geolocation?.model
    }
    
    // MARK: Init without details
    
    init(id: Int32, name: String, imageURL: String) {
        self.id = id
        self.name = name
        self.imageURL = imageURL
        self.isFavourite = false
    }
    
    func update(data: CityDetailsDecodableProtocol) {
        self.population = data.population
        self.rating = data.rating
        self.cityDescription = data.cityDescription
        self.detailText = data.detailText
        self.didCheckDetails = true
        self.geolocation = data.geolocation
    }
    
    var viewModel: CityCellViewModel {
        return CityCellViewModel(city: self)
    }
    
}
