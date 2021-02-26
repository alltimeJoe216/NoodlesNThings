//
//  MenuCollectionViewCell.swift
//  NoodlesNThings
//
//  Created by Joseph Veverka on 2/25/21.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblMenuTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lblMenuTitle.textColor = UIColor.gray
    }
    
    override var isSelected: Bool {
        didSet{
            
            lblMenuTitle.textColor = isSelected ? UIColor.selectedTextColor : UIColor.deselectedTextcolor
            
        }
    }
    
    
}
