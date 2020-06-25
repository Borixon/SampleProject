//
//  CityViewModel.swift
//  HSBC
//
//  Created by Michał Krupa on 23/06/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

class CityViewModel {

    public let headerNibName = "CityHeaderCell"
    public let infoNibName = "InfoCell"
    public let headerCellIdentifier = "CityHeaderCellIdentifier"
    public let commonCellIdentifier = "CommonCellIdentifier"
    public let numberOfSections = 2
    
    var model: CityModel!
    weak var vc: CityViewController?
    
    var coordinates: GeolocationProtocol {
        return model.geolocation ?? GeolocationProtocol(longitude: 0, latidute: 0)
    }
    
    public func rowsIn(_ section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 3
        }
    }
    
    public func dataFor<T>(indexPath: IndexPath) -> T {
        if indexPath.section == 0 {
            return (model.name, model.detailText, model.image) as! T
        } else {
            switch indexPath.row {
            case 0:
                return "Population: \(model.population!)" as! T
            case 1:
                return "Rating: \(model.rating!)" as! T
            default:
                return model.cityDescription! as! T
            }
        }
    }
}
