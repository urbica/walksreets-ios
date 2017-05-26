//
//  PointOnMapPointOnMapConfigurator.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 26/05/2017.
//  Copyright © 2017 Urbica. All rights reserved.
//

import UIKit

class PointOnMapModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? PointOnMapViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: PointOnMapViewController) {

        let router = PointOnMapRouter()
        router.view = viewController

        let presenter = PointOnMapPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = PointOnMapInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
