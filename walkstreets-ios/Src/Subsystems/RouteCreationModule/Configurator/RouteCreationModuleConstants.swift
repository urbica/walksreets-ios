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

    static let greenRouteColors = [UIColor(hex: "FAFF91"), UIColor(hex: "7FFF7F"), UIColor(hex: "00E66D")]
    static let noizeRouteColors = [UIColor(hex: "FF73BF"), UIColor(hex: "FFB2D1"), UIColor(hex: "FFF2D4")]
    static let airRouteColors = [UIColor(hex: "CCFFFF"), UIColor(hex: "4CD9FF"), UIColor(hex: "00B2FF")]
    
    static let backgroundColors = [UIColor(hex: "00B866"), UIColor(hex: "FF61BF"), UIColor(hex: "0099FF")]
    
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

