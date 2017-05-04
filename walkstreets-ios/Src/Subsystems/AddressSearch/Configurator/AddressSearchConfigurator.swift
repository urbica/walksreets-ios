//
//  AddressSearchAddressSearchConfigurator.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 04/05/2017.
//  Copyright © 2017 Urbica. All rights reserved.
//

import UIKit

class AddressSearchModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? AddressSearchViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: AddressSearchViewController) {

        let router = AddressSearchRouter()

        let presenter = AddressSearchPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = AddressSearchInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
