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
            self.userLocationView.isHidden = false
            self.view.layoutIfNeeded()
        }) { (bool) in

        }
    }
    
    func hideRouteViews() {
        restartToInitial()
        timeViewHeightConstraint.constant = 0
        routeDetailsHeightConstraint.constant = 0
        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [], animations: {
            self.view.layoutIfNeeded()
            self.routeTimeView.alpha = 0
            self.userLocationView.isHidden = true
            self.routeDetailsView.alpha = 0
        }) { (bool) in
            self.routeTimeView.isHidden = true
            self.routeDetailsView.isHidden = true
            self.output.clearRoutes()
            
            DispatchQueue.main.async {
                if let annotations = self.mapView.annotations {
                    self.mapView.removeAnnotations(annotations)
                }
                
                if let layer = self.mapView.style?.layer(withIdentifier: "customLine") {
                    self.mapView.style?.removeLayer(layer)
                }
                
                if let source = self.mapView.style?.source(withIdentifier: "customLine") {
                    self.mapView.style?.removeSource(source)
                }
            }
        }
    }
    
    func showStartView() {
        mainStartViews.isHidden = false
        UIView.animate(withDuration: 0.3) { 
            self.mainStartViews.alpha = 1
            self.alertView.alpha = 0
            self.alertView.isHidden = true
        }
    }
    
    func showAlertView() {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 7
        let text = "APP CURRENTLY WORKS IN MOSCOW. SORRY 😥"
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
        alertLabel.attributedText = attributedString
        alertView.isHidden = false
        UIView.animate(withDuration: 0.3) { 
            self.alertView.alpha = 1
        }
    }
}
