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
        //mapView.styleURL = "" this will setup style
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
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(handleSingleTap))
        singleTap.require(toFail: doubleTap)
        mapView.addGestureRecognizer(singleTap)
    }
    
    func handleSingleTap(tap: UITapGestureRecognizer) {
        // convert tap location (CGPoint)
        // to geographic coordinates (CLLocationCoordinate2D)
        let location: CLLocationCoordinate2D = mapView.convert(tap.location(in: mapView), toCoordinateFrom: mapView)
                
        output.configureRoute(latitude: Double(location.latitude), longitude: Double(location.longitude))
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
