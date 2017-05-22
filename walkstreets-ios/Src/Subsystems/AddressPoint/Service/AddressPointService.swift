//
//  AddressPointService.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 5/22/17.
//  Copyright © 2017 Roman Ustiantcev. All rights reserved.
//

import MapKit
import Alamofire
import SwiftyJSON

class AddressPointService: RootApiService {
    
    func drawRoutsForPoints(firstPoint: CLLocationCoordinate2D, lastPoint: CLLocationCoordinate2D, completionHandler: @escaping(NSArray)->()) {
        
        let parameters: [String: Any] = [
            "x1": firstPoint.longitude,
            "y1": firstPoint.latitude,
            "x2": lastPoint.longitude,
            "y2": lastPoint.latitude ]
        
        getData(method: .post, endpoint: Config.ws, parameters: parameters, encoding: JSONEncoding.default, headers: nil, completionHandler: { (response) in
            
            if let result = response.json.array {
                
                let newRoutes = result.map {
                    Route(json: $0)
                }
                
                completionHandler(NSArray(array: newRoutes))
            }
            
        }) { (error) in
            print(error)
        }
        
    
    }
    
    
    
}
