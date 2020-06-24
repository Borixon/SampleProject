//
//  WebService.swift
//  Preglife
//
//  Created by Michał Krupa on 13/03/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

class WebService {
    
    public func getThumbImage(from stringURL: String, completion: @escaping ((UIImage?, Error?) -> Void)) {
        guard let url = URL(string: stringURL) else {
            completion(nil, MediaError.badThumbUrl)
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let imageData = data, let image = UIImage(data: imageData) {
                completion(image, nil)
            } else {
                completion(nil, error)
            }
        }.resume()
    }
    
    public func getCitiesList(completion: @escaping ((Data?, Error?) -> Void)) {
        URLSession.shared.dataTask(with: API.citiesURL) { data, response, error in
            if let jsonData = data {
                completion(jsonData, nil)
            } else {
                if data == nil {
                    completion(nil, MediaError.emptyData)
                } else {
                    completion(nil, MediaError.unknownError)
                }
            }
        }.resume()
    }
    
    public func getCityDetails(id: Int32, completion: @escaping ((Data?, Error?) -> Void)) {
        URLSession.shared.dataTask(with: API.detailsForCity(id)) { data, response, error in
            if let jsonData = data {
                completion(jsonData, nil)
            } else {
                if data == nil {
                    completion(nil, MediaError.emptyData)
                } else {
                    completion(nil, MediaError.unknownError)
                }
            }
        }.resume()
    }
    
    public func getDataVersion(completion: @escaping ((Data?, Error?) -> Void)) {
        URLSession.shared.dataTask(with: API.versionURL) { data, response, error in
            if let jsonData = data {
                completion(jsonData, nil)
            } else {
                if data == nil {
                    completion(nil, MediaError.emptyData)
                } else {
                    completion(nil, MediaError.unknownError)
                }
            }
        }.resume()
    }
}
