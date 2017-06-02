//
//  OnboardingOnboardingProtocols.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 28/05/2017.
//  Copyright © 2017 Urbica. All rights reserved.
//

import UIKit

protocol OnboardingViewInput: class {

    func setupInitialState()
    func goToStart()
}

protocol OnboardingViewOutput {
    
    var onboardingImages: [UIImage]? {get}
    
    func proceedToStart()
    func viewIsReady()
}
