//
//  RouteService.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 05/11/2016.
//  Copyright © 2016 Roman Ustiantcev. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation
import Mapbox
import Alamofire

class RouteService: NSObject, CLLocationManagerDelegate, MKMapViewDelegate {
    
    func getRoute(startPoint: (latitude: Double, longtitude: Double), complection: @escaping (AnyObject) -> ()) {
        
        //guard let userLocation = LocationManager.sharedInstance.currentLocation else {
            //return
        //}
        
        let userLocation = CLLocation(latitude: 55.7633, longitude: 37.6209)
        
        let lat = startPoint.latitude
        let lon = startPoint.longtitude

        
        let url: URL = URL(string: "http://136.243.154.153:5000/route/v1/driving/\(userLocation.coordinate.longitude),\(userLocation.coordinate.latitude);\(lon),\(lat)?overview=false&steps=true")!
        

        Alamofire.request(url).response { response in
            print(url)
            print(response)
        }
        
        let directionsRequest = MKDirectionsRequest()
        
        let markLocationUser = MKPlacemark(coordinate: userLocation.coordinate, addressDictionary: nil)
        
        let markLocationStart = MKPlacemark(coordinate: CLLocationCoordinate2DMake(startPoint.latitude, startPoint.longtitude), addressDictionary: nil)
        
        directionsRequest.source = MKMapItem(placemark: markLocationUser)
        directionsRequest.destination = MKMapItem(placemark: markLocationStart)
        directionsRequest.transportType = MKDirectionsTransportType.walking
        let directions = MKDirections(request: directionsRequest)
        var rectangle: MGLPolyline?
        
        directions.calculate { (response: MKDirectionsResponse?, error: Error?) in
            // calculate directions
            guard error == nil else {
                return
            }
            
            var coords: [CLLocationCoordinate2D] = []
            
            //let path = GMSMutablePath()
            
            if let routes = response?.routes {
                for route in routes {
                    let coordsPointer = UnsafeMutablePointer<CLLocationCoordinate2D>.allocate(capacity: route.polyline.pointCount)
                    route.polyline.getCoordinates(coordsPointer, range: NSMakeRange(0, route.polyline.pointCount))
                    for i in 0..<route.polyline.pointCount {
                        coords.append(coordsPointer[i])
                    }
                }
                // draw a route
                
                rectangle = MGLPolyline(coordinates: &coords, count: UInt(coords.count))
            }
            
            if let rectangle = rectangle {
                complection(rectangle)
            }
        }
    }
    
}
