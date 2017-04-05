//
//  StartScreenStartScreenConfigurator.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 05/04/2017.
//  Copyright © 2017 Urbica. All rights reserved.
//

import UIKit

class StartScreenModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? StartScreenViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: StartScreenViewController) {

        let presenter = StartScreenPresenter()
        presenter.view = viewController

        viewController.output = presenter
    }

}
