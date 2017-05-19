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
    func setupInitialState()
    func showRoute(polyline: AnyObject)
    func drawFirstLine(polyline: AnyObject)
    func showRouteAtIndex(index: Int)
    func updateRouteView(route: AnyObject)
    func addPointTuple(pointTuple: (CLLocationCoordinate2D, CLLocationCoordinate2D))
}

protocol RouteCreationModuleViewOutput {
    
    var timeIndex: Int {get set}
    var routeIndex: Int {get set}
    
    func openAbout()
    func openSearch()
    func walkMeAround(time: Int)
    func configureRoute(startPoint: (latitude: Double, longtitude: Double), endPoint: (latitude: Double, longitude: Double))
    func viewIsReady()
    func configureRouteDetailsWithEndPoint(endPoint: CLLocationCoordinate2D?) -> Bool
    func selectRouteAtIndex(index: Int)
    func clearRoutes()
}

protocol RouteCreationModuleModuleInput: class {

}

protocol RouteCreationModuleInteractorInput {
    func configureRoute(startPoint: (latitude: Double, longtitude: Double), endPoint: (latitude: Double, longitude: Double), type: String)
    func walkMeAround(coordinates: CLLocationCoordinate2D, time: Int)
    func drawShapes(features: NSArray, index: Int) 
}

protocol RouteCreationModuleInteractorOutput: class {
    
    var timeIndex: Int {get set}
    
    func addPointTuple(pointTuple: (CLLocationCoordinate2D, CLLocationCoordinate2D))
    func updateSecondLine(polyline: AnyObject)
    func showRoute(polyline: AnyObject)
    func setRoutes(routes: NSArray)
    func updateRouteView(route: AnyObject)
    
}

protocol RouteCreationModuleRouterInput {
    func openAbout()
    func openSearch()
}
