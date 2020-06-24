//
//  JSONParser.swift
//  AplikacjaMobilna
//
//  Created by Michał Krupa on 17/03/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import Foundation

public struct CityJSONParser {
    static func listToModel(_ data: Data) throws -> [CityModel] {
        do {
            let decoded = try JSONDecoder().decode([CityDecodableProtocol].self, from: data)
            return decoded.map({ $0.toModel() })
        } catch {
            throw MediaError.dataParsingError
        }
    }
    
    static func detailsToModel(_ data: Data) throws -> CityDetailsDecodableProtocol {
        do {
            return try JSONDecoder().decode(CityDetailsDecodableProtocol.self, from: data)
        } catch {
            throw MediaError.dataParsingError
        }
    }
}
