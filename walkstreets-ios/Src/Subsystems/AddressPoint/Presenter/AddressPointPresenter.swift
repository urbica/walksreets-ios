//
//  AddressPointAddressPointPresenter.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 04/05/2017.
//  Copyright © 2017 Urbica. All rights reserved.
//

import MapKit

class AddressPointPresenter: AddressPointModuleInput, AddressPointViewOutput, AddressPointInteractorOutput{

    weak var view: AddressPointViewInput!
    var interactor: AddressPointInteractorInput!
    var router: AddressPointRouterInput!
    
    init () {
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: AddressPointConstants.kPointUpdated), object: nil, queue: OperationQueue.main) { [weak self] _ in
            self?.view.updateMap()
        }
    }
    
    var routes = NSArray() {
        didSet {
            if routes.count > 0 {
                selectRouteAtIndex(index: routeIndex)
            }
        }
    }
    
    var timeIndex: Int = 0
    var routeIndex: Int = 0
    var multyLine: AnyObject?

    func viewIsReady() {

    }
    
    func drawRoutsForPoints(firstPoint: CLLocationCoordinate2D, lastPoint: CLLocationCoordinate2D) {
        interactor.drawRoutsForPoints(firstPoint: firstPoint, lastPoint: lastPoint)
    }
    
    func setRoutes(routes: NSArray) {
        self.routes = routes
    }
    
    func selectRouteAtIndex(index: Int) {
        interactor.drawShapes(features: routes, index: index)
    }
    
    func updateSecondLine(polyline: AnyObject) {
        drawFirstLine(polyline: polyline) {
            self.view.showRoute(polyline: self.multyLine!)
        }
    }
    
    func showRoute(polyline: AnyObject) {
        self.multyLine = polyline
    }
    
    func drawFirstLine(polyline: AnyObject, completion: ()->()) {
        view.drawFirstLine(polyline: polyline)
        completion()
    }
    
    func updateRouteView(route: AnyObject) {
        view.updateRouteView(route: route)
    }
    
    func dismiss() {
        router.dismiss()
    }
}
