//
//  Route.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 07/11/2016.
//  Copyright © 2016 Roman Ustiantcev. All rights reserved.
//

import SwiftyJSON
import MapKit

class Route {
    
    var length: Double? = 0
    var time: Int? = 0
    var type: String? = nil
    var features: [Feature]? = nil
    var sw: CLLocationCoordinate2D? = nil
    var ne: CLLocationCoordinate2D? = nil
    var start: CLLocationCoordinate2D? = nil
    
    convenience init(json: JSON) {
        self.init()
        
        self.features = json.dictionary?["geom"]?["features"].map { Feature(json: $0.1)}
        
        self.length = json["length"].double
        self.time = json["time"].int
        self.type = json["type"].string
        if let zoom = json["zoom"].dictionary {
            
            if let sw = zoom["sw"]?.array {
                self.sw = CLLocationCoordinate2D(latitude: sw.last!.doubleValue, longitude: sw.first!.doubleValue)
            }
            
            if let ne = zoom["ne"]?.array {
                self.ne = CLLocationCoordinate2D(latitude: ne.last!.doubleValue, longitude: ne.first!.doubleValue)
            }
        }

        if let start = json["start"].array {
            self.start = CLLocationCoordinate2D(latitude: start.last!.doubleValue, longitude: start.first!.doubleValue)
        }
    }
}



