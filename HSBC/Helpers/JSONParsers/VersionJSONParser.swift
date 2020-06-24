//
//  VersionJSONParser.swift
//  HSBC
//
//  Created by Michał Krupa on 24/06/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import Foundation

public struct VersionJSONParser {
    static func parseVersion(_ data: Data) throws -> Float {
        do {
            let decoded = try JSONDecoder().decode(VersionProtocol.self, from: data)
            return decoded.dataVersion
        } catch {
            throw MediaError.dataParsingError
        }
    }
}
