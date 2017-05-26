//
//  PointOnMapPointOnMapPresenter.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 26/05/2017.
//  Copyright © 2017 Urbica. All rights reserved.
//

class PointOnMapPresenter: PointOnMapModuleInput, PointOnMapViewOutput, PointOnMapInteractorOutput{

    weak var view: PointOnMapViewInput!
    var interactor: PointOnMapInteractorInput!
    var router: PointOnMapRouterInput!

    func viewIsReady() {

    }
    
    func dismiss() {
        router.dismiss()
    }
}
