//
//  RootApiService.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 29/03/2017.
//  Copyright © 2017 Roman Ustiantcev. All rights reserved.
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
    let bodyResponse: String?
}

class RootApiService {
    
    let queue = DispatchQueue(label: "com.walkstreets.response-queue", qos: .userInteractive, attributes: [.concurrent])
    
    let host: String = Config.prodApiPoint
    
    func getData(method: Alamofire.HTTPMethod = .post, endpoint: String, parameters: [String: Any]? = nil, encoding: ParameterEncoding? = nil ,headers: HTTPHeaders? = nil, completionHandler: @escaping (APIResponse)->(), errorHandler: ((String) -> ())? = nil) {
        
        let url: String = host + endpoint
        
        var encoding = encoding
        
        //TODO: refactor encoding
        if encoding == nil {
            encoding = URLEncoding.default
        }
        
        Alamofire.request(url, method: method, parameters: parameters, encoding: encoding!, headers: headers).response(queue: queue, responseSerializer: DataRequest.jsonResponseSerializer()) { (response) in
            
            if response.result.isFailure == true {
                let error = response.result.error
                print(error!.localizedDescription)
                errorHandler?(error!.localizedDescription)
                return
            }
            
            guard response.result.value != nil else {
                print("Response result is nil")
                errorHandler?("Internal server error")
                return
            }
            
            let statusCode = response.response!.statusCode
            
            switch statusCode {
            case 500:
                let error = "Internal server error"
                print(error)
                errorHandler?(error)
                return
            default:
                break
            }
            
            let json = JSON(response.result.value!)
            
            guard json != JSON.null else {
                print("Error parsing JSON")
                errorHandler?("Internal server error")
                return
            }
            
            if let error = json["error"].string {
                errorHandler?(error)
                return
            }
            
            let bodyResponse = String(data: response.data!, encoding: String.Encoding.utf8)
            
            completionHandler(APIResponse(statusCode: response.response?.statusCode ?? 0, json: json, bodyResponse: bodyResponse))
            
        }
        
    }
}

