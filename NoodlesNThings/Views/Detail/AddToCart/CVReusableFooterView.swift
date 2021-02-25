//
//  SubItemCollectionViewCell.swift
//  NoodlesNThings
//
//  Created by Joseph Veverka on 2/25/21.
//

import UIKit

class CVReusableFooterView: UICollectionReusableView {
    @IBOutlet weak var orderNowButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        orderNowButton.layer.cornerRadius = 25.0
        orderNowButton.clipsToBounds = true
        orderNowButton.layer.borderWidth = 0.0
        orderNowButton.layer.borderColor = UIColor.clear.cgColor
    }
}
