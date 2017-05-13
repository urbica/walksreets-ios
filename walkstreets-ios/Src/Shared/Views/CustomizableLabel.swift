//
//  CustomizableLabel.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 02/05/2017.
//  Copyright © 2017 Roman Ustiantcev. All rights reserved.
//

import UIKit

class CustomizableLabel: UILabel {
    @IBInspectable var cornerRadius: CGFloat = 0
    @IBInspectable var borderWidth: CGFloat = 0
    @IBInspectable var selectedBorderWidth: CGFloat = 0
    @IBInspectable var borderColor: UIColor?
    @IBInspectable var horizontalInsets: CGFloat = 0
    @IBInspectable var verticalInsets: CGFloat = 0
    @IBInspectable var characterSpacing: CGFloat = 0 {
        didSet {
            setCharacterSpacing(value: characterSpacing)
        }
    }
    
    override func awakeFromNib() {
        layer.masksToBounds = true;
        layer.cornerRadius = cornerRadius
        
        if borderWidth > 0 {
            layer.borderWidth = borderWidth
        }
        
        if let color = borderColor {
            layer.borderColor = color.cgColor
        }
    }
    
    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.width += horizontalInsets * 2
        contentSize.height += verticalInsets * 2
        return contentSize
    }
    
    func setSelected(selected: Bool) {
        let width = selected ? selectedBorderWidth : 0
        let borderWidthAnimation = CABasicAnimation(keyPath: "borderWidth")
        borderWidthAnimation.fromValue = layer.borderWidth;
        borderWidthAnimation.toValue = width
        borderWidthAnimation.duration = 0.2
        
        layer.borderWidth = width
        layer.add(borderWidthAnimation, forKey: "border width")
    }
    
    func setCharacterSpacing(value: CGFloat) {
        if let textString = text {
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(NSKernAttributeName, value: value, range: NSRange(location: 0, length: attributedString.length - 1))
            attributedText = attributedString
        }
    }
}
