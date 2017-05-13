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
    
    static let noizeRouteColors = [UIColor(hex: "212B79"), UIColor(hex: "C0DEFF"), UIColor.white]
    static let greenRouteColors = [UIColor(hex: "17EB17"), UIColor(hex: "F5E273"), UIColor(hex: "EBFFD4")]
    static let airRouteColors = [UIColor(hex: "9B3390"), UIColor(hex: "E9C0A8"), UIColor(hex: "FFFFD8")]
    
    static func colorPickerForRoute(index: Int) -> [UIColor] {
        if index == 0 {
            return greenRouteColors
        } else if index == 1 {
            return noizeRouteColors
        } else {
            return airRouteColors
        }
    }
    
    
}

