//
//  AddressPointAddressPointConfigurator.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 04/05/2017.
//  Copyright © 2017 Urbica. All rights reserved.
//

import UIKit

class AddressPointModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? AddressPointViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: AddressPointViewController) {

        let router = AddressPointRouter()

        let presenter = AddressPointPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = AddressPointInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
