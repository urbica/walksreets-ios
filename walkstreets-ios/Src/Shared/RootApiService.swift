//
//  RootApiService.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 07/11/2016.
//  Copyright © 2016 Roman Ustiantcev. All rights reserved.
//

import Alamofire
import SwiftyJSON

struct APIError {
    let domain: String
    enum code: Int {
        case Unauthorized
        case NotFound
        case InternalServerError
    }
}

struct APIResponse {
    let statusCode: Int
    let json: JSON
}

class RootAPIService {
    
    var currentRequest: Request?

    
//    func getData(method: Alamofire.Method = .POST, endpoint: String, parameters: [String : AnyObject]? = nil, cancellable: Bool = false, completionHandler: @escaping (APIResponse) -> (), errorHandler: ((String) -> ())? = nil) {
//        
//        let request = ApiManager.defaultManager.request(method, endpoint, parameters: parameters)
//        
//        if cancellable {
//            currentRequest?.cancel()
//            currentRequest = request
//        }
//        
//        request.responseJSON(completionHandler: { [weak self] (response) in
//            
//            if response.result.isFailure == true {
//                let error = response.result.error
//                switch error!.code {
//                case -1009:
//                    print(error!.localizedDescription)
//                    errorHandler?(error!.localizedDescription)
//                    return
//                case -999:
//                    print("Request cancelled")
//                    return
//                default:
//                    break
//                }
//            }
//            
//            guard response.result.value != nil else {
//                print("Response result is nil")
//                errorHandler?("Internal server error")
//                return
//            }
//            
//            let statusCode = response.response!.statusCode
//            
//            switch statusCode {
//            case 401:
//                return
//            case 500:
//                let error = "Internal server error"
//                print(error)
//                errorHandler?(error)
//                return
//            default:
//                break
//            }
//            
//            let json = JSON(response.result.value!)
//            
//            guard json != nil else {
//                print("Error parsing JSON")
//                errorHandler?("Internal server error")
//                return
//            }
//            
//            if let error = json["error"].string {
//                errorHandler?(error)
//                return
//            }
//            
//            // workaround
//            if let error = json["errors"].dictionary?.first {
//                //                var errorString = error.0
//                //                if let description = error.1.first?.1.string {
//                //                    errorString.appendContentsOf(" " + description)
//                //                }
//                if let errorString = error.1.first?.1.string {
//                    errorHandler?(errorString)
//                }
//                return
//            }
//            
//            
//            completionHandler(APIResponse(statusCode: response.response?.statusCode ?? 0, json: json))
//            
//        })
//    }
}
