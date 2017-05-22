//
//  AddressPointAddressPointProtocols.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 04/05/2017.
//  Copyright © 2017 Urbica. All rights reserved.
//

import MapKit

protocol AddressPointViewInput: class {

    func setupInitialState()
    func showRoute(polyline: AnyObject)
    func drawFirstLine(polyline: AnyObject)
    func showRouteAtIndex(index: Int)
    func updateRouteView(route: AnyObject)
}

protocol AddressPointViewOutput {

    func viewIsReady()
    func drawRoutsForPoints(firstPoint: CLLocationCoordinate2D, lastPoint: CLLocationCoordinate2D)
    func selectRouteAtIndex(index: Int)
    func dismiss()
}

protocol AddressPointModuleInput: class {

}

protocol AddressPointInteractorInput {
    func drawRoutsForPoints(firstPoint: CLLocationCoordinate2D, lastPoint: CLLocationCoordinate2D)
    func drawShapes(features: NSArray, index: Int)
}

protocol AddressPointInteractorOutput: class {
    func setRoutes(routes: NSArray)
    func updateSecondLine(polyline: AnyObject)
    func showRoute(polyline: AnyObject)
    func updateRouteView(route: AnyObject)
}

protocol AddressPointRouterInput {
    func dismiss()
}
