//
//  CustomizableButton.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 02/05/2017.
//  Copyright © 2017 Roman Ustiantcev. All rights reserved.
//

import UIKit

class CustomizableButton: UIButton {
    
    @IBInspectable var titleLeftInset: CGFloat = 0
    @IBInspectable var titleRightInset: CGFloat = 0
    @IBInspectable var titleTopInset: CGFloat = 0
    @IBInspectable var titleBottomInset: CGFloat = 0
    
    @IBInspectable var selectedColor: UIColor?
    @IBInspectable var characterSpacing: CGFloat = 0 {
        didSet {
            setCharacterSpacing(value: characterSpacing)
        }
    }
    
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        backgroundColor = selectedColor
        return super.beginTracking(touch, with: event)
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        makeDelayAfter(delay: 0.1) {
            self.backgroundColor = UIColor.clear
        }
        super.endTracking(touch, with: event)
    }
    
    
    override func awakeFromNib() {
        titleEdgeInsets = UIEdgeInsetsMake(titleTopInset, titleLeftInset, titleBottomInset, titleRightInset)
    }
    
    func setCharacterSpacing(value: CGFloat) {
        if let textString = titleLabel?.text {
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(NSKernAttributeName, value: value, range: NSRange(location: 0, length: attributedString.length - 1))
            titleLabel?.attributedText = attributedString
        }
    }
}

