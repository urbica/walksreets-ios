//
//  RouteCreationModuleViewController+Maps.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 05/11/2016.
//  Copyright © 2016 Roman Ustiantcev. All rights reserved.
//

import Mapbox

extension RouteCreationModuleViewController : MGLMapViewDelegate {
    
    func setupMap() {
        
        // regular style
        
        if routeType == "regular" {
            mapView.styleURL = URL(string: "mapbox://styles/walkstreets/civ3x3k7h00482iozpl9et5mi")
            routeType = "regular"
        } else if routeType == "stepless" {
            mapView.styleURL = URL(string: "mapbox://styles/walkstreets/civ5iiv98002t2is5axe0myxx")
            routeType = "stepless"
        }
        
        // and wide sidewalks later: mapbox://styles/walkstreets/cinr4p56q00bfc7m5vxorbwog
        
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
        let longTap = UILongPressGestureRecognizer(target: self, action: #selector(handleLongTap))
        longTap.require(toFail: doubleTap)
        mapView.addGestureRecognizer(longTap)
    }
    
    func handleLongTap(tap: UILongPressGestureRecognizer) {
        if locationArray.isEmpty {
            let alertController = UIAlertController(title: "Start Location", message: "Are you sure it will be your start location?", preferredStyle: .actionSheet)
            
            let cancelaction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                let startLocation: CLLocationCoordinate2D = self.mapView.convert(tap.location(in: self.mapView), toCoordinateFrom: self.mapView)
                self.locationArray.append(startLocation)
            })
            alertController.addAction(cancelaction)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        } else {
            let alertController = UIAlertController(title: "Finish Location", message: "Are you sure it will be your finish location?", preferredStyle: .actionSheet)
            
            let cancelaction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                let finishLocation: CLLocationCoordinate2D = self.mapView.convert(tap.location(in: self.mapView), toCoordinateFrom: self.mapView)
                self.locationArray.append(finishLocation)
                self.configureRouteWithLocations()
            })
            alertController.addAction(cancelaction)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
        
        // convert tap location (CGPoint)
        // to geographic coordinates (CLLocationCoordinate2D)
        //let location: CLLocationCoordinate2D = mapView.convert(tap.location(in: mapView), toCoordinateFrom: mapView)
    }
    
    func configureRouteWithLocations() {
        output.configureRoute(startPoint: (latitude: (locationArray.last?.latitude)!, longtitude: (locationArray.last?.longitude)!), endPoint: (latitude: (locationArray.first?.latitude)!, longitude: (locationArray.first?.longitude)!), type: routeType)
    }
    
    func showRoute(polyline: AnyObject) {
                
        guard let polyline = polyline as? MGLPolyline else {
            return
        }
        
        DispatchQueue.main.async {
            [weak self] in
            
            self?.mapView.addAnnotation(polyline)
        }
    }
    
    func mapView(_ mapView: MGLMapView, strokeColorForShapeAnnotation annotation: MGLShape) -> UIColor {
        return UIColor.red
    }
    
    func mapView(_ mapView: MGLMapView, lineWidthForPolylineAnnotation annotation: MGLPolyline) -> CGFloat {
        return 2.0
    }

}
