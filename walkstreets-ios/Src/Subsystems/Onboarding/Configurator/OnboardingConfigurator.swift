//
//  OnboardingOnboardingConfigurator.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 28/05/2017.
//  Copyright © 2017 Urbica. All rights reserved.
//

import UIKit

class OnboardingModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? OnboardingViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: OnboardingViewController) {

        let presenter = OnboardingPresenter()
        presenter.view = viewController

        viewController.output = presenter
    }

}
