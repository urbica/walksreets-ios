//
//  ApiManager.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 07/11/2016.
//  Copyright © 2016 Roman Ustiantcev. All rights reserved.
//

import Alamofire

class ApiManager {
    
    static var defaultManager: Alamofire.SessionManager = {
        return ApiManager.setupManager()
    }()
    
    class func updateDefaultHeaders() {
        ApiManager.defaultManager = setupManager()
        
    }
    
    private class func setupManager() -> SessionManager {
        //        let serverTrustPolicies: [String: ServerTrustPolicy] = [
        //            ClientConfig.apiPath: .DisableEvaluation,
        //            ClientConfig.imagesPath: .DisableEvaluation
        //        ]
        
        let configuration = URLSessionConfiguration.default
        
        configuration.httpAdditionalHeaders = ApiManager.defaultHeaders()
        configuration.timeoutIntervalForRequest = 10
        
        return Alamofire.SessionManager(
            configuration: configuration
            //            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
        )
        
    }
    
    private class func defaultHeaders() -> [String : String] {
        let headers = Alamofire.SessionManager.defaultHTTPHeaders

        return headers
    }
}
