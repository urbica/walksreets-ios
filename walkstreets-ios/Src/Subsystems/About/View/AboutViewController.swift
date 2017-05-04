//
//  AboutAboutViewController.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 04/05/2017.
//  Copyright © 2017 Urbica. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController, AboutViewInput {

    var output: AboutViewOutput!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        AboutModuleConfigurator().configureModuleForViewInput(viewInput: self)
        output.viewIsReady()
    }


    // MARK: AboutViewInput
    func setupInitialState() {
    }
}
