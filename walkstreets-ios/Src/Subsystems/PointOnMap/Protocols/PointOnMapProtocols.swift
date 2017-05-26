//
//  PointOnMapPointOnMapProtocols.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 26/05/2017.
//  Copyright © 2017 Urbica. All rights reserved.
//

protocol PointOnMapViewInput: class {

    func setupInitialState()
}

protocol PointOnMapViewOutput {

    func viewIsReady()
    func dismiss()
}

protocol PointOnMapModuleInput: class {

}

protocol PointOnMapInteractorInput {

}

protocol PointOnMapInteractorOutput: class {

}

protocol PointOnMapRouterInput {
    func dismiss()
}
