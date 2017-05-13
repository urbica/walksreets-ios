//
//  RouteCreationModuleRouteCreationModulePresenter.swift
//  walkstreets-ios
//
//  Created by Roman Ustuantsev on 05/11/2016.
//  Copyright © 2016 Urbica. All rights reserved.
//

import MapKit

class RouteCreationModulePresenter: RouteCreationModuleModuleInput, RouteCreationModuleViewOutput, RouteCreationModuleInteractorOutput{

    weak var view: RouteCreationModuleViewInput!
    var interactor: RouteCreationModuleInteractorInput!
    var router: RouteCreationModuleRouterInput!
    let geoCoder = CLGeocoder()
    
    
    var routes = NSArray() {
        didSet {
            //view.showRouteAtIndex(index: 0)
        }
    }
    
    var timeIndex: Int = 0 {
        didSet {
            //interactor.walkMeAround(coordinates: Location.core.getCoordinate(), time: timeIndex)
        }
    }
    
    var routeIndex: Int = 0 {
        didSet {
            //selectRouteAtIndex(index: routeIndex)
        }
    }

    func viewIsReady() {

    }
    
    func configureRouteDetailsWithEndPoint(endPoint: CLLocationCoordinate2D?) -> Bool {
        
        guard let locationLat = endPoint?.latitude else {
            return false
        }
        guard let locationLon = endPoint?.longitude else {
            return false
        }
        
        geoCoder.reverseGeocodeLocation(CLLocation(latitude: locationLat, longitude: locationLon), completionHandler: { (placemarks, error) -> Void in
            
            // Place details
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            
            guard let street = placeMark.addressDictionary?["Thoroughfare"] as? NSString else {
                return
            }
            
            guard let address = placeMark.addressDictionary?["Name"] as? NSString else {
                return
            }
            
            //self.view.configureRouteDetailsView(address: address as String, street: street as String)
        })
        
        return true

    }
    
    func walkMeAround(time: Int) {
        interactor.walkMeAround(coordinates: Location.core.getCoordinate(), time: time)
    }
    
    func setRoutes(routes: NSArray) {
        self.routes = routes
    }
    
    func clearRoutes() {
        self.routes = []
    }
    
    func selectRouteAtIndex(index: Int) {
        interactor.drawShapes(features: routes, index: index)
    }
    
    func configureRoute(startPoint: (latitude: Double, longtitude: Double), endPoint: (latitude: Double, longitude: Double)) {
        //interactor.configureRoute(startPoint: startPoint, endPoint: endPoint, type: routeType)
    }
    
    func showRoute(polyline: AnyObject) {
        view.showRoute(polyline: polyline)
    }
    
    func updateRouteView(route: AnyObject) {
        view.updateRouteView(route: route)
    }
    
    func addPointTuple(pointTuple: (CLLocationCoordinate2D, CLLocationCoordinate2D)) {
        view.addPointTuple(pointTuple:pointTuple)
    }
    
    func openAbout() {
        router.openAbout()
    }
    
    func openSearch() {
        router.openSearch()
    }
}
