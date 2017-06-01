//
//  UIApplication+Helpers.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 01/06/2017.
//  Copyright © 2017 Roman Ustiantcev. All rights reserved.
//

import UIKit

extension UIApplication {
    func topMostViewController() -> UIViewController? {
        return self.keyWindow?.rootViewController?.topMostViewController()
    }
}
