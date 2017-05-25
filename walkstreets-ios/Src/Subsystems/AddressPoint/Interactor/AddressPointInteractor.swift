//
//  AddressPointAddressPointInteractor.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 04/05/2017.
//  Copyright © 2017 Urbica. All rights reserved.
//

import Mapbox

class AddressPointInteractor: AddressPointInteractorInput {

    weak var output: AddressPointInteractorOutput!
    lazy var addressPointService = AddressPointService()

    func drawRoutsForPoints(firstPoint: CLLocationCoordinate2D, lastPoint: CLLocationCoordinate2D) {
        addressPointService.drawRoutsForPoints(firstPoint: firstPoint, lastPoint: lastPoint) { [weak self](routes) in
            self?.output.setRoutes(routes: routes)
        }
    }
    
    func drawShapes(features: NSArray, index: Int) {
        guard features.count > 0 else { return }
        let colors = RouteCreationModuleConstants.colorPickerForRoute(index: index)
        if let route = features[index] as? Route {
            if let features = route.features {
                var multyPolylines: [CustomAnnotation]? = []
                var secondMultyPolylines: [MGLPolyline]? = []
                for feature in features {
                    let polyline = CustomAnnotation(coordinates: feature.coordinates!, count: UInt((feature.coordinates?.count)!))
                    if feature.color == 1 {
                        polyline.color = colors[0]
                    } else if feature.color == 2 {
                        polyline.color = colors[1]
                    } else {
                        polyline.color = colors[2]
                    }
                    polyline.width = 3
                    multyPolylines?.append(polyline)
                    
                    let polylineTwo = MGLPolyline(coordinates: feature.coordinates!, count: UInt((feature.coordinates?.count)!))
                    secondMultyPolylines?.append(polylineTwo)
                    
                }
                let lineOne = MGLMultiPolyline(polylines: secondMultyPolylines!)

                DispatchQueue.main.async {
                    self.output.showRoute(polyline: multyPolylines as AnyObject)
                    self.output.updateSecondLine(polyline: lineOne as AnyObject)
                    self.output.updateRouteView(route: route as AnyObject)
                }
            }
        }
    }
    
}
