//
//  RouteCreationModuleRouteCreationModuleRouter.swift
//  walkstreets-ios
//
//  Created by Roman Ustuantsev on 05/11/2016.
//  Copyright © 2016 Urbica. All rights reserved.
//

class RouteCreationModuleRouter: RouteCreationModuleRouterInput {

    weak var view: RouteCreationModuleViewController?
    
    func openAbout() {
        view?.performSegue(withIdentifier: "openAbout", sender: nil)
    }
    
    func openSearch() {
        view?.performSegue(withIdentifier: "openSearch", sender: nil)
    }
    
}
