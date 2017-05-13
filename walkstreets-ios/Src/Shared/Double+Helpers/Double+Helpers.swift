//
//  Double+Helpers.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 13/05/2017.
//  Copyright © 2017 Roman Ustiantcev. All rights reserved.
//

import Foundation

extension Double {
    /// Rounds the double to decimal places value
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
