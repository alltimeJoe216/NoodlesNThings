//
//  Extensioin+UIView.swift
//  NoodlesNThings
//
//  Created by Joseph Veverka on 2/25/21.
//

import UIKit

extension UIView {
    func setGradientBackground(colorOne:UIColor, colorTwo:UIColor) {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = [0.5, 1.7]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func addParallaxToView(vw: UIView) {
        let amount = 50
        
        let horizontal = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        horizontal.minimumRelativeValue = -amount
        horizontal.maximumRelativeValue = amount
        
        let vertical = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        vertical.minimumRelativeValue = -amount
        vertical.maximumRelativeValue = amount
        
        let group = UIMotionEffectGroup()
        group.motionEffects = [vertical]
        vw.addMotionEffect(group)
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    class func fromNib(named: String? = nil) -> Self {
            let name = named ?? "\(Self.self)"
            guard
                let nib = Bundle.main.loadNibNamed(name, owner: nil, options: nil)
                else { fatalError("missing expected nib named: \(name)") }
            guard
                /// we're using `first` here because compact map chokes compiler on
                /// optimized release, so you can't use two views in one nib if you wanted to
                /// and are now looking at this
                let view = nib.first as? Self
                else { fatalError("view of type \(Self.self) not found in \(nib)") }
            return view
        }
}
