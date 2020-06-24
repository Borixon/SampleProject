//
//  LabelFactory.swift
//  AplikacjaMobilna
//
//  Created by Michał Krupa on 19/03/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

struct LabelFactory {
    static public func createLabel(lines: Int = 0, font: UIFont, text: String, tag: Int = 0, textColor: UIColor = .white) -> UILabel {
        let label = UILabel()
        label.textColor = textColor
        label.numberOfLines = lines
        label.text = text
        label.font = font
        return label
    }
    
    static public func createCityCellLabel(with text: String, label: inout UILabel?) {
        label?.textColor = .darkGray
        label?.numberOfLines = 0
        label?.text = text
        label?.font = Fonts.mainMedium
        label?.lineBreakMode = .byWordWrapping
        label?.textAlignment = .justified
    }
}

struct Fonts {
    static let mainSmall = UIFont(name: "Helvetica", size: 9)!
    static let mainMedium = UIFont(name: "Helvetica", size: 13)!
    static let mainMediumLarge = UIFont(name: "Helvetica", size: 15)!
    static let mainLarge = UIFont(name: "Helvetica", size: 17)!
    static let mainLargeBold = UIFont(name: "Helvetica-Bold", size: 17)!
}

