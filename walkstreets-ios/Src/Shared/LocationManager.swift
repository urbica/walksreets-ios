//
//  LocationManager.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 05/11/2016.
//  Copyright © 2016 Roman Ustiantcev. All rights reserved.
//

import CoreLocation

class LocationManager: NSObject {
    static let sharedInstance = LocationManager()
    
    static let LocationDidChangeNotification = "LocationDidChangeNotification"
    var currentLocation: CLLocation?
    
    private var locationManager: CLLocationManager? = CLLocationManager()
    private var lastUpdatedLocation: CLLocation?
    
    override init() {
        super.init()
    }
    
    func start() {
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.delegate = self
        locationManager?.distanceFilter = 5
        locationManager?.startUpdatingLocation()
    }
    
    func getDistanceTo(lat: Double, lon: Double) -> String? {
        
        guard let distance = distanceTo(lat: lat, lon: lon) else {
            return nil
        }
        
        let distanceString = distance > 1000 ? "\(Int(distance / 1000)) km" : "\(Int(distance)) m"
        
        return distanceString
    }
    
    func distanceTo(lat: Double, lon: Double) -> Double? {
        
        guard !(lat == 0 && lon == 0) else {
            return nil
        }
        
        let toLocation = CLLocation(latitude: lat, longitude: lon)
        let distance = currentLocation?.distance(from: toLocation)
        return distance
    }
    
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else {
            return
        }
        
        let distanceToLocation = distanceTo(lat: location.coordinate.latitude, lon: location.coordinate.longitude)!
        
        if currentLocation == nil || distanceToLocation >= 100.0 {
            currentLocation = locations.last!
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: LocationManager.LocationDidChangeNotification), object: nil)
            
        }
    }
}
