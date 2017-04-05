//
//  LocationManager.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 05/11/2016.
//  Copyright © 2016 Roman Ustiantcev. All rights reserved.
//

import Foundation
import CoreLocation

public protocol LocationProtocol {
    
    var manager: CLLocationManager { get }
    var desiredAccuracy: CLLocationAccuracy { get set }
    var distanceFilter: CLLocationDistance { get set }
    var pausesLocationUpdates: Bool { get set }
    var monitoringAlavialbe: Bool {get set}
    func startUpdating()
    func stopUpdating()
    func monitorNewRegion(_ region: CLCircularRegion)
    func stopMonitorRegion(_ region: CLCircularRegion)
    func getLocationAccuracy() -> String
    func getCoordinate() -> CLLocationCoordinate2D
    func checkIfEnabled() -> Bool
    init()
}

fileprivate class LocationManagerDelegate: NSObject, CLLocationManagerDelegate {
    
    deinit {
        print("Location Core Deinitialized")
    }
    
    internal func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    
    internal func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        NSLog("\(error)")
    }
    
    internal func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        NSLog("\(error)")
    }
    
    internal func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
    }
    
    internal func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
        switch  state {
        case .inside:
            break
        case .outside:
            break
        default:
            break
        }
        
    }
    
    internal func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            break
        case .denied :
            manager.requestWhenInUseAuthorization()
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .restricted:
            manager.requestWhenInUseAuthorization()
        }
    }
    
    
}

struct Location: LocationProtocol {
    
    public var desiredAccuracy: CLLocationAccuracy
    public var distanceFilter: CLLocationDistance
    public var pausesLocationUpdates: Bool
    public var monitoringAlavialbe: Bool
    
    public static var core: LocationProtocol = Location()
    
    public var manager = CLLocationManager()
    fileprivate var managerDelegate = LocationManagerDelegate()
    
    init() {
        self.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        self.distanceFilter = kCLDistanceFilterNone
        self.pausesLocationUpdates = false
        self.monitoringAlavialbe =  CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self)
        manager.delegate = managerDelegate
        manager.requestWhenInUseAuthorization()
        if #available(iOS 9.0, *) {
            manager.allowsBackgroundLocationUpdates = true
        }
    }
    
    public func startUpdating() {
        self.manager.startUpdatingLocation()
    }
    
    public func stopUpdating() {
        self.manager.stopUpdatingLocation()
    }
    
    public func checkIfEnabled() -> Bool {
        return CLLocationManager.locationServicesEnabled()
    }
    
    public func monitorNewRegion(_ region: CLCircularRegion) {
        region.notifyOnEntry = true
        self.manager.startMonitoring(for: region)
    }
    
    public func stopMonitorRegion(_ region: CLCircularRegion) {
        self.manager.startMonitoring(for: region)
    }
    
    public func getLocationAccuracy() -> String {
        
        if (self.manager.location!.horizontalAccuracy < 0)
        {
            print("No Signal")
            return "No Signal"
        }
        else if (self.manager.location!.horizontalAccuracy > 163)
        {
            print("Poor Signal")
            return "Poor"
        }
        else if (self.manager.location!.horizontalAccuracy > 48)
        {
            print("Average Signal")
            return "Average"
        }
        else
        {
            print("Full Signal")
            return "Full"
        }
    }
    
    public func getCoordinate() -> CLLocationCoordinate2D {
        
        guard let location = self.manager.location else {
            return CLLocationCoordinate2D()
        }
        
        return location.coordinate
    }
    
}
