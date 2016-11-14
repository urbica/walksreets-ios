//
//  RouteCreationApiService.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 07/11/2016.
//  Copyright © 2016 Roman Ustiantcev. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
import MapKit

protocol RouteCreationApiServiceDelegate: class {
    func updateRoute(genre: RouteEntityProtocol)
}

class RouteCreationApiService: RootAPIService {
    
    var genreEntity: RouteEntityProtocol?
    weak var delegate: RouteCreationApiServiceDelegate?
    
}
