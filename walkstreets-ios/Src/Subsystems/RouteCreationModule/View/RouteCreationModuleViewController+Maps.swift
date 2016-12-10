//
//  RouteCreationModuleViewController+Maps.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 05/11/2016.
//  Copyright © 2016 Roman Ustiantcev. All rights reserved.
//

import Mapbox
import MapKit

extension RouteCreationModuleViewController : MGLMapViewDelegate {
    
    func setupMap() {
        
        mapView.delegate = self
        
        // regular style
        
        if routeType == "regular" {
            mapView.styleURL = RouteCreationModuleConstants.regularRouteStyle
            routeType = "regular"
        } else if routeType == "stepless" {
            mapView.styleURL = RouteCreationModuleConstants.steplessRouteStyle
            routeType = "stepless"
        }
        
        // TODO: wide sidewalks later: mapbox://styles/walkstreets/cinr4p56q00bfc7m5vxorbwog
        
        mapView.setCenter(RouteCreationModuleConstants.moscowCenterCoordinate, zoomLevel: 13, animated: false)
        mapView.compassView.isHidden = true
        setupTapMap()
    }
    
    func setupTapMap() {
        // double tapping zooms the map, so ensure that can still happen
        let doubleTap = UITapGestureRecognizer(target: self, action: nil)
        doubleTap.numberOfTapsRequired = 2
        mapView.addGestureRecognizer(doubleTap)
        
        // delay single tap recognition until it is clearly not a double
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        singleTap.numberOfTapsRequired = 1
        singleTap.require(toFail: doubleTap)
        mapView.addGestureRecognizer(singleTap)
    }
    
    func handleTap(tap: UITapGestureRecognizer) {
        
        let tapLocation: CLLocationCoordinate2D = mapView.convert(tap.location(in: mapView), toCoordinateFrom: mapView)
        
        if locationArray.isEmpty {
            let alertController = UIAlertController(title: "Start Location", message: "Are you sure it will be your start location?", preferredStyle: .actionSheet)
            
            let cancelaction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                print("You tapped at: \(tapLocation.latitude), \(tapLocation.longitude)")

                self.locationArray.insert(tapLocation, at: 0)
            })
            alertController.addAction(cancelaction)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        } else {
            let alertController = UIAlertController(title: "Finish Location", message: "Are you sure it will be your finish location?", preferredStyle: .actionSheet)
            
            let cancelaction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                self.locationArray.insert(tapLocation, at: 1)
                print("You tapped at: \(tapLocation.latitude), \(tapLocation.longitude)")
                self.configureRouteWithLocations()
            })
            alertController.addAction(cancelaction)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func configureRouteWithLocations() {
        output.configureRoute(startPoint: (latitude: (locationArray.last?.latitude)!, longtitude: (locationArray.last?.longitude)!), endPoint: (latitude: (locationArray.first?.latitude)!, longitude: (locationArray.first?.longitude)!), type: routeType)
    }
    
    func showRoute(polyline: MGLPolyline) {
        DispatchQueue.main.async { [weak self] in
            self?.mapView.addAnnotation(polyline)
        }
    }
    
    func mapView(_ mapView: MGLMapView, strokeColorForShapeAnnotation annotation: MGLShape) -> UIColor {
        return UIColor.red
    }
    
    func mapView(_ mapView: MGLMapView, lineWidthForPolylineAnnotation annotation: MGLPolyline) -> CGFloat {
        return 5.0
    }
    
    func mapView(_ mapView: MGLMapView, alphaForShapeAnnotation annotation: MGLShape) -> CGFloat {
        return 1.0
    }
}
