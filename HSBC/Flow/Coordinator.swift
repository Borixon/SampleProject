//
//  Coordinator.swift
//  HSBC
//
//  Created by Michał Krupa on 23/06/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

class Coordinator {
    
    private let navigationController = UINavigationController()
    private let loadingScreenTag: Int = 1000
    
    var rootViewController: UIViewController {
        return navigationController
    }
    
    func start() {
        let vc = MainViewController.instantiate()
        vc.coordinator = self
        navigationController.setViewControllers([vc], animated: true)
    }
    
    func openCity(_ cityModel: CityModel) {
        DispatchQueue.main.async {
            let vc = CityViewController.instantiate()
            vc.updateViewModel(cityModel: cityModel)
            vc.coordinator = self
            self.navigationController.pushViewController(vc, animated: true)
        }
    }
    
    func insertLoadingScreen() {
        DispatchQueue.main.async {
            let loading = LoadingViewController.instantiate()
            loading.view.tag = self.loadingScreenTag
            loading.view.alpha = 0
            UIApplication.shared.keyWindow?.addSubview(loading.view)
            UIView.animate(withDuration: 0.1, animations: {
                loading.view.alpha = 1
            })
        }
    }
    
    func removeLoadingScreen() {
        DispatchQueue.main.async {
            let loading = UIApplication.shared.keyWindow?.subviews.filter({ $0.tag == self.loadingScreenTag }).first
            UIView.animate(withDuration: 0.1, animations: {
                loading?.alpha = 0
            }, completion: { finish in
                loading?.removeFromSuperview()
            })
        }
    }
    
    func showCity(geolocation: GeolocationProtocol) {
        let vc = MapViewController.instantiate()
        vc.coordinator = self
        vc.set(coordinates: geolocation)
        navigationController.modalPresentationStyle = .currentContext
        navigationController.present(vc, animated: true, completion: nil)
    }
    
    func showError(_ error: Error) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
            self.navigationController.topViewController?.present(alert, animated: true, completion: nil)
        }
    }
    
    func popViewController() {
        navigationController.dismiss(animated: true, completion: nil)
    }
}
