//
//  CustomizableView.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 02/05/2017.
//  Copyright © 2017 Roman Ustiantcev. All rights reserved.
//

import UIKit

class CustomizableView: UIView {
    @IBInspectable var cornerRadius: CGFloat = 0
    @IBInspectable var borderWidth: CGFloat = 0
    @IBInspectable var borderColor: UIColor?
    @IBInspectable var shadowColor: UIColor?
    @IBInspectable var shadowX: CGFloat = 0
    @IBInspectable var shadowY: CGFloat = 0
    @IBInspectable var shadowBlur: CGFloat = 0
    @IBInspectable var shadowOpacity: Float = 0
    @IBInspectable var shouldRasterize: Bool = false
    @IBInspectable var gradientEnabled: Bool = false
    @IBInspectable var gradientDirection: String = "up"
    
    let gradient: CAGradientLayer = CAGradientLayer()
    
    override func awakeFromNib() {
        layer.masksToBounds = true
        layer.borderWidth = borderWidth
        layer.cornerRadius = cornerRadius
        
        if let color = borderColor {
            layer.borderColor = color.cgColor
        }
        
        enableShadow()
        
        if gradientEnabled == true {
            
            if gradientDirection == "down" {
                gradient.startPoint = CGPoint(x: 0, y: 1.0)
                gradient.endPoint = CGPoint(x: 0, y: 0)
            }
            
            gradient.frame = bounds
            gradient.colors = [UIColor.colorFromHexString(hexString: "060606"), UIColor(white: 0, alpha: 0.85).cgColor]
            layer.insertSublayer(gradient, at: 0)
            superview?.layoutIfNeeded()
        }
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        self.gradient.frame = self.bounds
    }
    
    func enableShadow() {
        if let shadowColor = shadowColor {
            layer.shadowColor = shadowColor.cgColor
            layer.shadowOffset = CGSize(width: shadowX, height: shadowY)
            layer.shadowRadius = shadowBlur
            layer.shadowOpacity =  shadowOpacity
            layer.shouldRasterize = shouldRasterize
        }
    }
    
    func disableShadow() {
        layer.shadowColor = nil
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 0
        layer.shadowOpacity =  0
        layer.shouldRasterize = shouldRasterize
    }
    
}
