//
//  API.swift
//  AplikacjaMobilna
//
//  Created by Michał Krupa on 22/03/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import Foundation

public struct API {
    private static let baseUrl = "https://raw.githubusercontent.com/Borixon/publicData/master/"
    
    public static let citiesURL = URL(string: baseUrl + "/citiesList.json")!
    public static let versionURL = URL(string: baseUrl + "/version.json")!
    
    public static func detailsForCity(_ id: Int32) -> URL {
        return URL(string: baseUrl + "/details/\(id).json")!
    }
}
