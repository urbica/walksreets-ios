//
//  UIViewController+Helpers.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 01/06/2017.
//  Copyright © 2017 Roman Ustiantcev. All rights reserved.
//

import UIKit

extension UIViewController {
    func topMostViewController() -> UIViewController {
        if self.presentedViewController == nil {
            return self
        }
        if let navigation = self.presentedViewController as? UINavigationController {
            return navigation.visibleViewController!.topMostViewController()
        }
        return self.presentedViewController!.topMostViewController()
    }
}
