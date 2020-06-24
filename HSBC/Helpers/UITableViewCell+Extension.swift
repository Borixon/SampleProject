//
//  UITableViewCell+Extension.swift
//  HSBC
//
//  Created by Michał Krupa on 24/06/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

extension UITableViewCell {
    public func prepareForCityView() {
        textLabel?.numberOfLines = 0
        textLabel?.lineBreakMode = .byWordWrapping
        textLabel?.textAlignment = .justified
        textLabel?.textColor = UIColor(white: 0.13, alpha: 1)
        textLabel?.font = Fonts.mainMedium
        backgroundColor = UIColor(white: 0.96, alpha: 1)
        selectionStyle = .none
    }
}
