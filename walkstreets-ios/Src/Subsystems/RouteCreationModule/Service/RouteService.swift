//
//  RouteService.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 05/11/2016.
//  Copyright © 2016 Roman Ustiantcev. All rights reserved.
//

import Foundation
import MapKit
import GoogleMaps
import CoreLocation

class RouteService: NSObject, CLLocationManagerDelegate, MKMapViewDelegate {
    
    func getRoute(startPoint: (latitude: Double, longtitude: Double), complection: @escaping (AnyObject) -> ()) {
        
        guard let userLocation = LocationManager.sharedInstance.currentLocation else {
            return
        }
        
        let directionsRequest = MKDirectionsRequest()
        
        let markLocationUser = MKPlacemark(coordinate: userLocation.coordinate, addressDictionary: nil)
        
        let markLocationStart = MKPlacemark(coordinate: CLLocationCoordinate2DMake(startPoint.latitude, startPoint.longtitude), addressDictionary: nil)
        
        // check distance for route
        
        let locationOne = CLLocation(latitude: markLocationUser.coordinate.latitude, longitude: markLocationUser.coordinate.longitude)
        let locationTwo = CLLocation(latitude: startPoint.latitude, longitude: startPoint.longtitude)
        let distanceKm = Double(locationOne.distance(from: locationTwo) / 1000)
        
        guard distanceKm < 300 else {
            return
        }
        
        directionsRequest.source = MKMapItem(placemark: markLocationUser)
        directionsRequest.destination = MKMapItem(placemark: markLocationStart)
        directionsRequest.transportType = MKDirectionsTransportType.walking
        let directions = MKDirections(request: directionsRequest)
        var rectangle: GMSPolyline?
        
        directions.calculate(completionHandler: { (response: MKDirectionsResponse?, error: NSError?) -> Void in
            
            // calculate directions
            guard error == nil else {
                return
            }
            
            var coords: [CLLocationCoordinate2D] = []
            
            let path = GMSMutablePath()
            
            if let routes = response?.routes {
                for route in routes {
                    let coordsPointer = UnsafeMutablePointer<CLLocationCoordinate2D>.allocate(capacity: route.polyline.pointCount)
                    route.polyline.getCoordinates(coordsPointer, range: NSMakeRange(0, route.polyline.pointCount))
                    for i in 0..<route.polyline.pointCount {
                        coords.append(coordsPointer[i])
                    }
                }
                // draw a route
                
                for coord in coords {
                    path.add(coord)
                }
                rectangle = GMSPolyline(path: path)
            }
            
            if let rectangle = rectangle {
                complection(rectangle)
            }
        } as! MKDirectionsHandler)
    }
    
}
