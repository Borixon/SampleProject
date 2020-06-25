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
    var detailText: String?
    var population: Int64?
    var cityDescription: String?
    var rating: Float?
    var didCheckDetails: Bool = false
    var isFavourite: Bool
    var image: UIImage?
    var geolocation: GeolocationProtocol?
    
    init(_ entity: City) {
        self.id = entity.id
        self.name = entity.name
        self.imageURL = entity.imageLink
        self.isFavourite = entity.isFavourite
        self.didCheckDetails = entity.didCheckDetails
        self.detailText = entity.detailText
        self.population = entity.population
        self.cityDescription = entity.cityDescription
        self.rating = entity.rating
        self.geolocation = entity.geolocation?.model
    }
    
    init(id: Int32, name: String, imageURL: String) {
        self.id = id
        self.name = name
        self.imageURL = imageURL
        self.isFavourite = false
        self.didCheckDetails = false
    }
    
    func update(data: CityDetailsDecodableProtocol) {
        self.detailText = data.detailText
        self.population = data.population
        self.cityDescription = data.cityDescription
        self.rating = data.rating
        self.geolocation = data.geolocation
    }
    
    var viewModel: CityCellViewModel {
        return CityCellViewModel(city: self)
    }
    
}
