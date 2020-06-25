//
//  MapViewController.swift
//  HSBC
//
//  Created by Michał Krupa on 23/06/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: BaseViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var backButton: UIButton!
    
    let vm = MapViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRegion()
    }
    
    func set(coordinates: GeolocationProtocol) {
        vm.coordinates = coordinates
    }
    
    private func setupRegion() {
        mapView.setRegion(vm.coordinateRegion, animated: true)
    }
    
    @IBAction func dismissMap(_ sender: Any) {
        coordinator?.popViewController()
    }
}
