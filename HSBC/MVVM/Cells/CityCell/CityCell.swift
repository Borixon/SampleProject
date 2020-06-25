//
//  CityCell.swift
//  Preglife
//
//  Created by Michał Krupa on 13/03/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

class CityCell: UITableViewCell {
 
    @IBOutlet weak var thumb: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var label: UILabel!
     
    static let height: CGFloat = 110
    var vm: CityCellViewModel!
    
    override func awakeFromNib() {
        super.awakeFromNib() 
        self.thumb.contentMode = .scaleAspectFill
        self.thumb.layer.cornerRadius = 15
        self.thumb.layer.masksToBounds = true
        self.backgroundColor = .clear
        self.selectionStyle = .none
        self.prepareForReuse()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup(_ vm: CityCellViewModel) {
        self.vm = vm
        vm.cell = self
        label.text = vm.title
        thumb?.image = vm.thumbImage
        setupButton()
    }
    
    func setupButton() {
        if vm.isFavourite {
            favoriteButton.setImage(UIImage(named: "star-orange"), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(named: "star-gray"), for: .normal)
        }
    }
    
    @IBAction func favoritePressed(_ sender: Any) {
        vm.didPressFavourite()
        setupButton()
    } 
}
