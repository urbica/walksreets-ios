//
//  OnboardingOnboardingPresenter.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 28/05/2017.
//  Copyright © 2017 Urbica. All rights reserved.
//

import UIKit

class OnboardingPresenter: OnboardingViewOutput {

    weak var view: OnboardingViewInput!
    
    let onboardingImages: [UIImage]? = [UIImage(named: "onboard1")!,
                                        UIImage(named: "onboard2")!,
                                        UIImage(named: "onboard3")!,
                                        UIImage(named: "onboard4")!,
                                        UIImage(named: "onboard5")!]
    
    func viewIsReady() {

    }
    
    func proceedToStart() {
        UserDefaults.standard.set(true, forKey: Config.onboardingWasShownKey)
        view.goToStart()
    }
}
