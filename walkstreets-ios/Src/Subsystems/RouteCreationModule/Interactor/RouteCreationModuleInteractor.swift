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
    
    func configureRoute(latitude: Double, longitude: Double) {
        
        let startPoint = (latitude, longitude)
        
        routeService.getRoute(startPoint: startPoint){ [weak self] polyline in
            
            //self?.output.showRoute(polyline)
        }
    }
    
}
