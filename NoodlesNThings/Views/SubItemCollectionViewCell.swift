//
//  SubItemCollectionViewCell.swift
//  NoodlesNThings
//
//  Created by Joseph Veverka on 2/25/21.
//

import UIKit

class SubItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var backgroundSubListView: UIView!
    @IBOutlet weak var imageViewName: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sizePriceLLabel: UILabel!
    @IBOutlet weak var sizePriceMLabel: UILabel!
    
    var subItem: FoodSubItem? {
        didSet {
            if let imageName = subItem?.imageName {
                imageViewName.image = UIImage(named: imageName)
            }
            nameLabel.text = subItem?.name
            sizePriceLLabel.text = subItem?.sizeLPrice
            sizePriceMLabel.text = subItem?.sizeMPrice
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.contentView.layer.cornerRadius = 8.0
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true
        
        self.layer.shadowOffset = .zero
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 12.0
        self.layer.shadowPath = UIBezierPath(roundedRect:self.bounds, cornerRadius:self.contentView.layer.cornerRadius).cgPath
    }
    
    
}
