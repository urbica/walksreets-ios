//
//  OnStartHelper.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 18/05/2017.
//  Copyright © 2017 Roman Ustiantcev. All rights reserved.
//

import UIKit
import MapKit

class OnStartHelper {
    
    class func showStartScreenIfNeeded() {
        
        let window = UIApplication.shared.keyWindow
        var storyboard: UIStoryboard!
        let status = CLLocationManager.authorizationStatus()
        if status == .denied || status == .restricted || status == .notDetermined {
            storyboard = UIStoryboard(name: "StartScreen", bundle: nil)
        } else {
            storyboard = UIStoryboard(name: "RouteCreationModule", bundle: nil)
        }
        
        let viewController = storyboard.instantiateInitialViewController()
        window?.rootViewController = viewController
    }
    
}
