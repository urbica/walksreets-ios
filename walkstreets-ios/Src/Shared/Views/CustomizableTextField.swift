//
//  CustomizableTextField.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 04/05/2017.
//  Copyright © 2017 Roman Ustiantcev. All rights reserved.
//

import UIKit
import Spring

class CustomizableTextField: SpringTextField {
    @IBInspectable var cornerRadius: CGFloat = 0
    @IBInspectable var borderWidth: CGFloat = 0
    @IBInspectable var borderColor: UIColor?
    @IBInspectable var attrPlaceholderText: String?
    @IBInspectable var attrPlaceholderColor: UIColor?
    @IBInspectable var attrPlaceholderDefaultFontSize: CGFloat = 0
    @IBInspectable var horizontalInsets: CGFloat = 0
    @IBInspectable var verticalInsets: CGFloat = 0
    @IBInspectable var leftImage: String?
    
    @IBInspectable var characterSpacing: CGFloat = 0 {
        didSet {
            setCharacterSpacing(value: characterSpacing)
        }
    }
    
    override func awakeFromNib() {
        layer.masksToBounds = true;
        layer.borderWidth = borderWidth
        layer.cornerRadius = cornerRadius
        contentVerticalAlignment = .center;
        
        if let color = borderColor {
            layer.borderColor = color.cgColor
        }
        
        if let placeholder = attrPlaceholderText {
            var attrs = [String : AnyObject]()
            if let placeholderColor = attrPlaceholderColor {
                attrs[NSForegroundColorAttributeName] = placeholderColor
            }
            if attrPlaceholderDefaultFontSize > 0 {
                attrs[NSFontAttributeName] = UIFont.systemFont(ofSize: attrPlaceholderDefaultFontSize)
            }
            
            attrs[NSBaselineOffsetAttributeName] = verticalInsets as AnyObject?
            
            let attributedString = NSMutableAttributedString(string: text!)
            attributedString.addAttribute(NSKernAttributeName, value: 2.2, range: NSRange(location: 0, length: attributedString.length))
            attributedText = attributedString
            
            attrs[NSKernAttributeName] = 2.2 as AnyObject
            
            attributedPlaceholder = NSAttributedString(string: placeholder, attributes: attrs)
        }
        
        if let leftImage = leftImage {
            leftViewMode = .always
            leftView = UIImageView(image: UIImage(named: leftImage))
        }
        
    }
    
    func setCharacterSpacing(value: CGFloat) {
        if let textString = text {
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(NSKernAttributeName, value: value, range: NSRange(location: 0, length: attributedString.length - 1))
            attributedText = attributedString
        }
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.leftViewRect(forBounds: bounds)
        if leftImage != nil {
            rect.origin.x += 8
        }
        return rect
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: horizontalInsets, dy: verticalInsets)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
}
