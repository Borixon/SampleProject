//
//  DecodableStructures.swift
//  HSBC
//
//  Created by Michał Krupa on 24/06/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import Foundation

public struct CityDecodableProtocol: Codable {
    let id: Int32
    let name: String
    let image: String
    
    func toModel() -> CityModel {
        return CityModel(id: id, name: name, imageURL: image)
    }
}

public struct CityDetailsDecodableProtocol: Codable {
    let id: Int32
    let cityDescription: String
    let detailText: String
    let rating: Float
    let population: Int64
    let geolocation: GeolocationProtocol
}

public struct GeolocationProtocol: Codable {
    let longitude: Double
    let latidute: Double
}

public struct VersionProtocol: Codable {
    let dataVersion: Float
    let update: String
}
