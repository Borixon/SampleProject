//
//  BaseViewController.swift
//  HSBC
//
//  Created by Michał Krupa on 23/06/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

open class BaseViewController: UIViewController, BaseViewControllerProtocol, StoryboardedProtocol {
 
    var coordinator: Coordinator?
    
    func openLoadingScreen() {
        coordinator?.insertLoadingScreen()
    }
    
    func hideLoadingScreen() {
        coordinator?.removeLoadingScreen()
    }
}

protocol BaseViewControllerProtocol {
    func hideLoadingScreen()
    func openLoadingScreen()
    var coordinator: Coordinator? { get set }
}
