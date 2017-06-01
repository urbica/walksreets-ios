//
//  Storyboard+Helpers.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 01/06/2017.
//  Copyright © 2017 Roman Ustiantcev. All rights reserved.
//

import UIKit

extension UIStoryboard {
    class var mainInterfaceStoryboard: UIStoryboard {
        return UIStoryboard(name: "RouteCreationModule", bundle: nil)
    }
    
    class var addressStoryboard: UIStoryboard {
        return UIStoryboard(name: "AddressSearch", bundle: nil)
    }
}
