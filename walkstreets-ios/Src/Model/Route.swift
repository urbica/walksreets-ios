//
//  Route.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 07/11/2016.
//  Copyright © 2016 Roman Ustiantcev. All rights reserved.
//

import SwiftyJSON

class Route {
    
    var length: Double? = 0
    var time: Int? = 0
    var type: String? = nil
    var geometry: Geometry? = nil
    
    convenience init(json: JSON) {
        self.init()
        
        self.length = json["length"].double
        self.time = json["time"].int
        self.type = json["type"].string
        
        self.geometry = Geometry(json: json["geom"])
    }
    
}
