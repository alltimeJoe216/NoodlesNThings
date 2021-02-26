//
//  Extension+UIImage.swift
//  NoodlesNThings
//
//  Created by Joseph Veverka on 2/25/21.
//

import UIKit
extension UIImage {
    func getCropRatio() -> CGFloat {
        let widthRatio = CGFloat(self.size.width/self.size.height)
        return widthRatio
    }
}
