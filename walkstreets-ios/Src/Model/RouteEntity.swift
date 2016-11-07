//
//  RouteEntity.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 07/11/2016.
//  Copyright © 2016 Roman Ustiantcev. All rights reserved.
//

import SwiftyJSON

protocol RouteEntityProtocol: class {
    var descr: String? {get}
    var duration: Duration? {get}
    var type: String? {get}
}

class RouteEntity : RouteEntityProtocol {
    
    dynamic var descr: String? = nil
    var duration: Duration? = nil
    dynamic var type: String? = nil
    
}
