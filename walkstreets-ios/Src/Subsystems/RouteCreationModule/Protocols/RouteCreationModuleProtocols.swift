//
//  RouteCreationModuleRouteCreationModuleProtocols.swift
//  walkstreets-ios
//
//  Created by Roman Ustuantsev on 05/11/2016.
//  Copyright © 2016 Urbica. All rights reserved.
//

import UIKit
import Foundation
import MapKit
import Mapbox

protocol RouteCreationModuleViewInput: class {
    
    var routeType: String {get}
    
    func setupInitialState()
    func showRoute(polyline: AnyObject)
    func showRouteAtIndex(index: Int)
    func addPointTuple(pointTuple: (CLLocationCoordinate2D, CLLocationCoordinate2D))
}

protocol RouteCreationModuleViewOutput {
    func openAbout()
    func openSearch()
    func walkMeAround()
    func configureRoute(startPoint: (latitude: Double, longtitude: Double), endPoint: (latitude: Double, longitude: Double))
    func viewIsReady()
    func configureRouteDetailsWithEndPoint(endPoint: CLLocationCoordinate2D?) -> Bool
}

protocol RouteCreationModuleModuleInput: class {

}

protocol RouteCreationModuleInteractorInput {
    func configureRoute(startPoint: (latitude: Double, longtitude: Double), endPoint: (latitude: Double, longitude: Double), type: String)
    func walkMeAround(coordinates: CLLocationCoordinate2D)
}

protocol RouteCreationModuleInteractorOutput: class {
    func addPointTuple(pointTuple: (CLLocationCoordinate2D, CLLocationCoordinate2D))
    func showRoute(polyline: AnyObject)
    func setRoutes(routes: NSArray)
}

protocol RouteCreationModuleRouterInput {
    func openAbout()
    func openSearch()
}
