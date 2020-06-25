//
//  CityCellViewModel.swift
//  HSBC
//
//  Created by Michał Krupa on 23/06/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import Foundation
import UIKit

class CityCellViewModel {
    
    var model: CityModel
    weak var cell: CityCell?
    
    init(city: CityModel) {
        self.model = city
        if city.image == nil {
            getThumbPhoto()
        }
    }
    
    var title: String {
        return model.name
    }
    
    var isFavourite: Bool {
        return model.isFavourite
    }
    
    var thumbImage: UIImage? {
        return model.image
    }
    
    func didPressFavourite() {
        model.isFavourite = !model.isFavourite
    }
    
    func getThumbPhoto() {
        let webService = WebService()
        webService.getThumbImage(from: model.imageURL, completion: { image, error  in
            self.model.image = image
            DispatchQueue.main.async {
                self.cell?.thumb.image = image
            }
        })
    }
}
