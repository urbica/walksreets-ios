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
    func openRouteDetailsView()
    func showRoute(polyline: MGLPolyline)
    func configureRouteDetailsView(address: String, street: String)
}

protocol RouteCreationModuleViewOutput {
    func configureRoute(startPoint: (latitude: Double, longtitude: Double), endPoint: (latitude: Double, longitude: Double), type: String)
    func viewIsReady()
    func configureRouteDetailsWithEndPoint(endPoint: CLLocationCoordinate2D?)
}

protocol RouteCreationModuleModuleInput: class {

}

protocol RouteCreationModuleInteractorInput {
    func configureRoute(startPoint: (latitude: Double, longtitude: Double), endPoint: (latitude: Double, longitude: Double), type: String)
}

protocol RouteCreationModuleInteractorOutput: class {
    func showRoute(polyline: MGLPolyline)
}

protocol RouteCreationModuleRouterInput {

}
