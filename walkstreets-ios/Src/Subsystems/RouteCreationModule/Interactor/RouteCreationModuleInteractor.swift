//
//  RouteCreationModuleRouteCreationModuleInteractor.swift
//  walkstreets-ios
//
//  Created by Roman Ustuantsev on 05/11/2016.
//  Copyright © 2016 Urbica. All rights reserved.
//

import Alamofire
import Mapbox

class RouteCreationModuleInteractor: RouteCreationModuleInteractorInput {
    
    weak var output: RouteCreationModuleInteractorOutput!
    lazy var routeService = RouteService()
    
    
    func configureRoute(startPoint: (latitude: Double, longtitude: Double), endPoint: (latitude: Double, longitude: Double), type: String) {
        
        let parameters: Parameters = ["lon_a": startPoint.longtitude,
                                      "lat_a": startPoint.latitude,
                                      "lon_b": endPoint.longitude,
                                      "lat_b": endPoint.latitude]
        var endpoint = ""
        
        if type == "regular" {
            endpoint = Config.routeEndpoint
        } else if type == "green" {
            endpoint = Config.greenEndpoint
        }
        
        routeService.getNewRouteWithType(parameters: parameters, endpoint: endpoint) { [weak self](points) in
            var rectangle: MGLPolyline?
            var coordsArrayValues = points
            
            let pointTuple: (CLLocationCoordinate2D, CLLocationCoordinate2D) = (coordsArrayValues.first!, coordsArrayValues.last!)
            
            rectangle = MGLPolyline(coordinates: &coordsArrayValues, count: UInt(coordsArrayValues.count))
            
            if let rectangle = rectangle {
                DispatchQueue.main.async {
                    self?.output.addPointTuple(pointTuple: pointTuple)
                    self?.output.showRoute(polyline: rectangle)
                }
            }
        }
    }
    
    func walkMeAround(coordinates: CLLocationCoordinate2D) {
        routeService.walkMeAround(userCoordinates: coordinates) {
            
        }
    }
}
