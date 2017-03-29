//
//  RouteService.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 05/11/2016.
//  Copyright © 2016 Roman Ustiantcev. All rights reserved.
//

import Foundation
import MapKit
import Mapbox
import Alamofire
import SwiftyJSON

class RouteService: RootApiService {
        
    func getNewRouteWithType(parameters: [String: Any],  completionHandler: @escaping ([CLLocationCoordinate2D]) -> ()) {
        
        getData(method: .post, endpoint: Config.routeEndpoint, parameters: parameters, encoding: URLEncoding.httpBody, headers: nil, completionHandler: { (response) in
            var coor = [CLLocationCoordinate2D]()
            if let featuresArray = response.json["features"].array {
                for feature in featuresArray {
                    if let coordinates = feature.dictionary?["geometry"]?["coordinates"].array {
                        for coordinate in coordinates {
                            coor.append(CLLocationCoordinate2D(latitude: coordinate[1].double!, longitude: coordinate[0].double!))
                        }
                        completionHandler(coor)
                    }
                    
                }
            }
        }) { (error) in
            print(error)
        }
        
    }
    
//    func parseJSON(json: JSON) -> [JSON]? {
//        
//        let legs = json["routes"].arrayValue.first?["legs"]
//        let steps = legs?.arrayValue.first?["steps"].arrayValue
//        
//        return steps
//        
//    }
//    
//    
//    func getRoute(coordinatesArray: [CLLocationCoordinate2D], complection: @escaping (AnyObject) -> ()) {
//        
//        var rectangle: MGLPolyline?
//        
//        var coordsArrayValues = coordinatesArray
//        
//        // draw a route
//        
//        rectangle = MGLPolyline(coordinates: &coordsArrayValues, count: UInt(coordsArrayValues.count))
//    
//        if let rectangle = rectangle {
//            complection(rectangle)
//        }
//    }
    
}
