//
//  CustomizableTextView.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 04/05/2017.
//  Copyright © 2017 Roman Ustiantcev. All rights reserved.
//

import UIKit

class CustomizableTextView: UITextView {
    
    @IBInspectable var characterSpacing: CGFloat = 0 {
        didSet {
            setCharacterSpacing(value: characterSpacing)
        }
    }
    
    func setCharacterSpacing(value: CGFloat) {
        if let textString = text {
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(NSKernAttributeName, value: value, range: NSRange(location: 0, length: attributedString.length - 1))
            attributedText = attributedString
        }
    }

}
