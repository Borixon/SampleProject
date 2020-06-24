//
//  MediaError.swift
//  AplikacjaMobilna
//
//  Created by Michał Krupa on 22/03/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import Foundation

public enum MediaError: String, Error {
    case badThumbUrl = "Bad url"
    case emptyData = "Empty data"
    case unknownError = "Unknown error"
    case dataParsingError = "Data parsking error"
}
