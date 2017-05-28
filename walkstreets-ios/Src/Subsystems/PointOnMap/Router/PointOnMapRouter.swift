//
//  PointOnMapPointOnMapRouter.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 26/05/2017.
//  Copyright © 2017 Urbica. All rights reserved.
//

class PointOnMapRouter: PointOnMapRouterInput {

    weak var view: PointOnMapViewController?
    
    func dismiss() {
        
        if let controllers = self.view?.navigationController?.viewControllers {
            view?.navigationController?.popToViewController(controllers[0], animated: true)
        }
        
       // _ = view?.navigationController?.popViewController(animated: true)
    }
    
}
