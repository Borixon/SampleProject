//
//  CityHeaderCell.swift
//  HSBC
//
//  Created by Michał Krupa on 23/06/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

class CityHeaderCell: UITableViewCell {

    @IBOutlet weak var cityImage: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    static let height: CGFloat = 200
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cityImage.layer.masksToBounds = true
        cityImage.layer.cornerRadius = 15
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func setup(title: String, detailText: String, image: UIImage?) {
        cityImage.image = image
        cityLabel.text = title
        detailLabel.text = detailText
    }
    
}
