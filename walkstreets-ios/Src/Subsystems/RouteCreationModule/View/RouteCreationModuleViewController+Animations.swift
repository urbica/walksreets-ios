//
//  RouteCreationModuleViewController+Animations.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 05/11/2016.
//  Copyright © 2016 Roman Ustiantcev. All rights reserved.
//

import UIKit

extension RouteCreationModuleViewController {
    
    func showRouteViews() {
        
        routeTimeView.isHidden = false
        routeDetailsView.isHidden = false
        timeViewHeightConstraint.constant = 60
        routeDetailsHeightConstraint.constant = 182
        
        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [], animations: {
            self.routeTimeView.alpha = 1
            self.routeDetailsView.alpha = 1
            self.view.layoutIfNeeded()
        }) { (bool) in

        }
    }
    
    func hideRouteViews() {
        timeViewHeightConstraint.constant = 0
        routeDetailsHeightConstraint.constant = 0
        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [], animations: {
            self.view.layoutIfNeeded()
            self.routeTimeView.alpha = 0
            self.routeDetailsView.alpha = 0
        }) { (bool) in
            self.routeTimeView.isHidden = true
            self.routeDetailsView.isHidden = true
        }
    }
}
