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
            
            self.view.configureRouteDetailsView(address: address as String, street: street as String)
        })
        
        return true

    }
    
    func configureRoute(startPoint: (latitude: Double, longtitude: Double), endPoint: (latitude: Double, longitude: Double), type: String) {
        interactor.configureRoute(startPoint: startPoint, endPoint: endPoint, type: type)
    }
    
    func showRoute(polyline: AnyObject) {
        DispatchQueue.main.async {
            self.view.showRoute(polyline: polyline)
        }
    }
    
}
