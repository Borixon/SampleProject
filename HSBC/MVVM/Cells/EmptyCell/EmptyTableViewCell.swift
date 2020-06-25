//
//  EmptyTableViewCell.swift
//  Preglife
//
//  Created by Michał Krupa on 14/03/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

class EmptyTableViewCell: UITableViewCell {

    static let height: CGFloat = 56
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
