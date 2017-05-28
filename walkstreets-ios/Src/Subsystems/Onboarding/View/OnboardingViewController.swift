//
//  OnboardingOnboardingViewController.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 28/05/2017.
//  Copyright © 2017 Urbica. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController, OnboardingViewInput {

    var output: OnboardingViewOutput!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        OnboardingModuleConfigurator().configureModuleForViewInput(viewInput: self)
        output.viewIsReady()
        setupInitialState()
    }


    // MARK: OnboardingViewInput
    func setupInitialState() {
    }
}
