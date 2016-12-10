//
//  RouteCreationModuleConstants.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 05/11/2016.
//  Copyright © 2016 Roman Ustiantcev. All rights reserved.
//

import UIKit
import Mapbox

struct RouteCreationModuleConstants {
    
    static let moscowCenterCoordinate = CLLocationCoordinate2D(latitude: 55.7552, longitude: 37.6180)
    static let regularRouteStyle = URL(string: "mapbox://styles/walkstreets/civ3x3k7h00482iozpl9et5mi")
    static let steplessRouteStyle = URL(string: "mapbox://styles/walkstreets/civ5iiv98002t2is5axe0myxx")
    static let mainApiPoint = "http://routes.walkstreets.org/regular/route/v1/driving/"
    
}

