//
//  PointOnMapPointOnMapPresenter.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 26/05/2017.
//  Copyright © 2017 Urbica. All rights reserved.
//

import Mapbox

class PointOnMapPresenter: PointOnMapModuleInput, PointOnMapViewOutput, PointOnMapInteractorOutput{

    weak var view: PointOnMapViewInput!
    var interactor: PointOnMapInteractorInput!
    var router: PointOnMapRouterInput!

    var routes = NSArray() {
        didSet {
            if routes.count > 0 {
                selectRouteAtIndex(index: routeIndex)
            }
        }
    }
    
    var routeIndex: Int  { return view.selectedPriorityIndex! }
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
