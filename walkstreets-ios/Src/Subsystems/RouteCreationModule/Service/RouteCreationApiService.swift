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

protocol RouteCreationApiServiceDelegate: class {
    func updateRoute(genre: RouteEntityProtocol)
}

class RouteCreationApiService: RootAPIService {
    
    var genreEntity: RouteEntityProtocol?
    weak var delegate: RouteCreationApiServiceDelegate?
    
    func getNewRouteWithType(type: String, completionBlock: (JSON) -> Void, erroBlock: (String) -> ()) {
        
        //let endPoint = Config.routeEndpoint + "/" + String(type)
        
        //getData(.GET, endpoint: endPoint, completionHandler: { (response) in
        //    dispatch_async(dispatch_get_main_queue(), {
        //        completionBlock(response.json)
        //    })
            
        //}) { (error) in
        //    erroBlock(error)
        //}
    }
    
}
