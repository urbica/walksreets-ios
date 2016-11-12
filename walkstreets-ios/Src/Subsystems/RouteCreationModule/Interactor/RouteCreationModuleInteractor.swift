//
//  RouteCreationModuleRouteCreationModuleInteractor.swift
//  walkstreets-ios
//
//  Created by Roman Ustuantsev on 05/11/2016.
//  Copyright © 2016 Urbica. All rights reserved.
//

class RouteCreationModuleInteractor: RouteCreationModuleInteractorInput {
    
    weak var output: RouteCreationModuleInteractorOutput!
    lazy var routeService = RouteService()
    
    
    func configureRoute(startPoint: (latitude: Double, longtitude: Double), endPoint: (latitude: Double, longitude: Double), type: String) {
        
        routeService.getRoute(startPoint: startPoint, endPoint: endPoint, type: type, complection: { [weak self] polyline in
            
            self?.output.showRoute(polyline: polyline)
            
        })
    }
    
    
}
