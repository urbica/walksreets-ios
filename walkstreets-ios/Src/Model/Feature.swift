//
//  Feature.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 11/05/2017.
//  Copyright © 2017 Roman Ustiantcev. All rights reserved.
//

import SwiftyJSON
import MapKit

class Feature {
    
    var coordinates: [CLLocationCoordinate2D]? = []
    var id: String? = nil
    var color: Int? = 0
    
    convenience init(json: JSON) {
        self.init()
        
        _ = json["geometry"]["coordinates"].array?.forEach({ (coordinate) in
            self.coordinates?.append(CLLocationCoordinate2D(latitude: coordinate[1].doubleValue, longitude: coordinate[0].doubleValue))
        })
        
        self.id = json["properties"].dictionary?["id"]?.string
        self.color = json["properties"].dictionary?["color"]?.int
    }
}
