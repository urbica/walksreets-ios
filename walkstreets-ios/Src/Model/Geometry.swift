//
//  Geometry.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 11/05/2017.
//  Copyright © 2017 Roman Ustiantcev. All rights reserved.
//

import MapKit
import SwiftyJSON

class Geometry {
    
    var color: [Int]? = []
    var coordinates = [CLLocationCoordinate2D]()
    
    convenience init(json: JSON) {
        self.init()
        
        if let features = json["features"].array {
            
            _ = features.map { $0.dictionary?["geometry"]?["coordinates"].array?.forEach({ (coordinate) in
                coordinates.append(CLLocationCoordinate2D(latitude: coordinate[1].doubleValue, longitude: coordinate[0].doubleValue))
            })}
            
            _ = features.map {
                if let colorNumber = $0.dictionary?["properties"]?["color"].int {
                    color?.append(colorNumber)
                }
            }
        }
    }
}
