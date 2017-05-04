//
//  RouteCreationModuleRouteCreationModuleConfigurator.swift
//  walkstreets-ios
//
//  Created by Roman Ustuantsev on 05/11/2016.
//  Copyright © 2016 Urbica. All rights reserved.
//

import UIKit

class RouteCreationModuleModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? RouteCreationModuleViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: RouteCreationModuleViewController) {

        let router = RouteCreationModuleRouter()
        router.view = viewController

        let presenter = RouteCreationModulePresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = RouteCreationModuleInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
