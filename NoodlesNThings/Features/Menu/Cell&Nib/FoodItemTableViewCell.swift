//
//  FoodItemTableViewCell.swift
//  NoodlesNThings
//
//  Created by Joseph Veverka on 2/25/21.
//

import UIKit

class FoodItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgViewItem: UIImageView!
    
    @IBOutlet weak var itemNameLabel: UILabel!
    
    @IBOutlet weak var numberOfItemsLabel: UILabel!
    
    @IBOutlet weak var viewGradient: UIView!
    
    var item: FoodItem? {
        didSet {
            
            if let imageName = item?.itemImageName {
                imgViewItem.image = UIImage(named: imageName)
            }
            itemNameLabel.text = item?.itemName
            numberOfItemsLabel.text = item?.noOfItems
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       // viewGradient.setGradientBackground(colorOne: .clear, colorTwo: .black)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
