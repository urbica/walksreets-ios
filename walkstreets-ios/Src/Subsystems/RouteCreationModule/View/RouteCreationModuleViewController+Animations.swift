//
//  RouteCreationModuleViewController+Animations.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 05/11/2016.
//  Copyright © 2016 Roman Ustiantcev. All rights reserved.
//

import UIKit

extension RouteCreationModuleViewController {
    
    func closeRouteDetailsView() {
        view.layoutIfNeeded()
        routeDetailsView.layoutIfNeeded()
        routeDetailsHeightConstraint.constant = 0
        
        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [], animations: {
            self.routeDetailsView.alpha = 0
            self.routeDetailsView.layoutIfNeeded()
            self.view.layoutIfNeeded()
        }, completion: { (bool) in
            self.routeDetailsView.isHidden = true
        })
    }
    
    func openRouteDetailsView() {
        view.layoutIfNeeded()
        routeDetailsView.isHidden = false
        routeDetailsView.layoutIfNeeded()
        routeDetailsHeightConstraint.constant = 144
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [], animations: {
            
            self.routeDetailsView.alpha = 1
            self.routeDetailsView.layoutIfNeeded()
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func openRouteTypeView() {
        view.layoutIfNeeded()
        routeTypeView.isHidden = false
        routeTypeView.layoutIfNeeded()
        routeTypeViewHeightConstraint.constant = -136
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [], animations: {
            self.routeTypeView.alpha = 1
            self.routeTypeView.layoutIfNeeded()
            self.view.layoutIfNeeded()
        }, completion: { (bool) in

        })
    }
    
    func closeRouteTypeView() {
        view.layoutIfNeeded()
        routeTypeView.layoutIfNeeded()
        routeTypeViewHeightConstraint.constant = 20
        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [], animations: {
            self.routeTypeView.alpha = 0
            self.routeTypeView.layoutIfNeeded()
            self.view.layoutIfNeeded()
        }, completion: { (bool) in
            self.routeTypeView.isHidden = true
        })
    }
}
