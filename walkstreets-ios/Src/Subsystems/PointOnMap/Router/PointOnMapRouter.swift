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
        view?.dismiss(animated: true, completion: nil)
        _ = view?.navigationController?.popViewController(animated: true)
    }
    
}
