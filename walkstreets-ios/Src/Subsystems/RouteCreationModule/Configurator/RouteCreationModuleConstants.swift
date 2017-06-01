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

    static let greenRouteColors = [UIColor(hex: "F7FF66"), UIColor(hex: "66FF66"), UIColor(hex: "00B86C")]
    static let noizeRouteColors = [UIColor(hex: "FF73B2"), UIColor(hex: "FFBFB2"), UIColor(hex: "FFFFB2")]
    static let airRouteColors = [UIColor(hex: "99FFFF"), UIColor(hex: "00A6FF"), UIColor(hex: "004CFF")]
    
    static let backgroundColors = [UIColor(hex: "009969"), UIColor(hex: "D962AD"), UIColor(hex: "0045FF")]
    
    static let walkMe = "walkMe"
    
    static func colorPickerForRoute(index: Int) -> [UIColor] {
        if index == 0 {
            return greenRouteColors
        } else if index == 1 {
            return noizeRouteColors
        } else {
            return airRouteColors
        }
    }
    
    static func colorForBackground(index: Int) -> UIColor? {
        return backgroundColors[index]
    }
    
    
}

