//
//  StartScreenStartScreenViewController.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 05/04/2017.
//  Copyright © 2017 Urbica. All rights reserved.
//

import UIKit

class StartScreenViewController: UIViewController, StartScreenViewInput {

    var output: StartScreenViewOutput!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        StartScreenModuleConfigurator().configureModuleForViewInput(viewInput: self)
        output.viewIsReady()
    }


    // MARK: StartScreenViewInput
    func setupInitialState() {
    }
}
