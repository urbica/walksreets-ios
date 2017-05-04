//
//  AboutAboutConfigurator.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 04/05/2017.
//  Copyright © 2017 Urbica. All rights reserved.
//

import UIKit

class AboutModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? AboutViewController {
            configure(viewController)
        }
    }

    private func configure(viewController: AboutViewController) {

        let presenter = AboutPresenter()
        presenter.view = viewController

        viewController.output = presenter
    }

}
