//
//  UIColor+Helpers.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 02/05/2017.
//  Copyright © 2017 Roman Ustiantcev. All rights reserved.
//

import UIKit

extension UIColor {
    public class func colorFromHexString(hexString: String) -> UIColor {
        return colorFromHexString(hexString: hexString, alpha: 1.0)
    }
    
    public class func colorFromHexString(hexString: String, alpha: Float) -> UIColor {
        let colorString = hexString.replacingOccurrences(of: "#", with: "").uppercased() as NSString
        let red, blue, green: Float
        red = self.colorComponentsFrom(string: colorString, start: 0, length: 2)
        green = self.colorComponentsFrom(string: colorString, start: 2, length: 2)
        blue = self.colorComponentsFrom(string: colorString, start: 4, length: 2)
        return UIColor(colorLiteralRed: red, green: green, blue: blue, alpha: alpha)
    }
    
    private class func colorComponentsFrom(string: NSString, start: Int, length: Int) -> Float {
        NSMakeRange(start, length)
        let subString = string.substring(with: NSMakeRange(start, length))
        var hexValue: UInt32 = 0
        Scanner(string: subString).scanHexInt32(&hexValue)
        return Float(hexValue) / 255.0
    }
}
