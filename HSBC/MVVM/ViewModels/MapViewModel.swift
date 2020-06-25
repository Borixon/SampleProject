//
//  MapViewModel.swift
//  HSBC
//
//  Created by Michał Krupa on 23/06/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit
import MapKit

class MapViewModel {

    var coordinates: GeolocationProtocol!
    
    var coordinateRegion: MKCoordinateRegion {
        let center = CLLocationCoordinate2D(latitude: coordinates.latidute, longitude: coordinates.longitude)
        return MKCoordinateRegion(center: center, latitudinalMeters: 2500, longitudinalMeters: 2500)
    }
}
