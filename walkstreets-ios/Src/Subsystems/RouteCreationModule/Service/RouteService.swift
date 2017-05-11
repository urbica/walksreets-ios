//
//  RouteService.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 05/11/2016.
//  Copyright © 2016 Roman Ustiantcev. All rights reserved.
//

import Mapbox
import Alamofire
import SwiftyJSON

class RouteService: RootApiService {
    func getNewRouteWithType(parameters: [String: Any], endpoint: String, completionHandler: @escaping ([CLLocationCoordinate2D]) -> ()) {
        getData(method: .post, endpoint: Config.routeEndpoint, parameters: parameters, encoding: URLEncoding.httpBody, headers: nil, completionHandler: { (response) in
            var coor = [CLLocationCoordinate2D]()
            if let featuresArray = response.json["features"].array {
               _ = featuresArray.map { $0.dictionary?["geometry"]?["coordinates"].array?.forEach({ (coordinate) in
                    coor.append(CLLocationCoordinate2D(latitude: coordinate[1].doubleValue, longitude: coordinate[0].doubleValue))
                })}
                completionHandler(coor)
            }
        }) { (error) in
            print(error)
        }
        
    }
    
    func walkMeAround(userCoordinates:CLLocationCoordinate2D, completionHandler: @escaping(NSArray)->()) {
        
        let parameters: [String: Any] = [
            "x": userCoordinates.longitude,
            "y": userCoordinates.latitude,
            "time": 60
        ]
        
        getData(method: .post, endpoint: Config.beatifulPath, parameters: parameters, encoding: JSONEncoding.default, headers: nil, completionHandler: { (response) in

            if let routes = response.json.array?.first {
                guard let features = (routes.dictionary?["geom"]?["features"].map { Feature(json: $0.1) }) else { return }
                completionHandler(NSArray(array: features))
            }
            
        }) { (error) in
            print(error)
        }
    }
}
