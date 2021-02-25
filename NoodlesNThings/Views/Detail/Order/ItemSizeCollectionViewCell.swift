//
//  ItemSizeCollectionViewCell.swift
//  NoodlesNThings
//
//  Created by Joseph Veverka on 2/25/21.
//

import UIKit

class ItemSizeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var viewSize: UIView!
    
    @IBOutlet weak var imgViewItem: UIImageView!
    
    @IBOutlet weak var lblSize: UILabel!
    
   
    override var isSelected: Bool {
        didSet {
            viewSize.layer.borderColor = isSelected ? UIColor.redBorderColor : UIColor.commonBorderColor
            imgViewItem.image = isSelected ?  UIImage(named: "pizzaRed") :  UIImage(named: "pizzaGray")
            lblSize.textColor = isSelected ? UIColor.selectedTextColor : UIColor.deselectedTextcolor
            
        }
    }
    
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewSize.layer.cornerRadius = 8.0
        viewSize.clipsToBounds = true
        viewSize.layer.borderWidth = 1.0
        viewSize.layer.borderColor = UIColor.commonBorderColor
        
    }
    
    

}
