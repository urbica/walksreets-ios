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

class RouteService: NSObject, CLLocationManagerDelegate, MKMapViewDelegate {
    
    let queue = DispatchQueue(label: "com.cnoon.response-queue", qos: .userInteractive, attributes: [.concurrent])
    
    func getNewRouteWithType(startPoint: (latitude: Double, longtitude: Double), endPoint: (latitude: Double, longitude: Double), type: String,  completionHandler: @escaping ([CLLocationCoordinate2D]) -> ()) {
        
        var coordsArrayValues = [CLLocationCoordinate2D]()
        
        var url = URL(string: "http://routes.walkstreets.org/regular/route/v1/driving/\(startPoint.longtitude),\(startPoint.latitude);\(endPoint.longitude),\(endPoint.latitude)?geometries=geojson&overview=false&steps=true")!
        
        if type != "regular" {
            url = URL(string: "http://routes.walkstreets.org/stepless/route/v1/driving/\(startPoint.longtitude),\(startPoint.latitude);\(endPoint.longitude),\(endPoint.latitude)?geometries=geojson&overview=false&steps=true")!
        }
        
        
        Alamofire.request(url, parameters: nil)
            .response(
                queue: queue,
                responseSerializer: DataRequest.jsonResponseSerializer(),
                completionHandler: { response in
                    //to get status code
                    if let status = response.response?.statusCode {
                        switch(status){
                        case 200:
                            print("example success")
                        default:
                            print("error with response status: \(status)")
                        }
                    }
                    
                    //to get JSON return value
                    let json = JSON(response.result.value!)
                    let legs = json["routes"].arrayValue.first?["legs"]
                    let steps = legs?.arrayValue.first?["steps"].arrayValue
                    let coordsArray = steps?.first?["geometry"].dictionaryValue["coordinates"]?.arrayValue
                    
                    guard coordsArray != nil else {
                        return
                    }
                    
                    for coord in coordsArray! {
                        
                        let lat = coord.array?.first?.double
                        let lon = coord.array?.last?.double
                        
                        let point = CLLocationCoordinate2D(latitude: lat!, longitude: lon!)
                        
                        coordsArrayValues.append(point)
                    }
                    completionHandler(coordsArrayValues)
            })
    }
    
    
    func getRoute(coordinatesArray: [CLLocationCoordinate2D], complection: @escaping (MGLPolyline) -> ()) {
        
        var rectangle: MGLPolyline?
        
        var coordsArrayValues = coordinatesArray
        
        // draw a route
        
        rectangle = MGLPolyline(coordinates: &coordsArrayValues, count: UInt(coordsArrayValues.count))
    
        if let rectangle = rectangle {
            complection(rectangle)
        }
    }
    
}
