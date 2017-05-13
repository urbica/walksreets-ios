//
//  AddressPointAddressPointViewController.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 04/05/2017.
//  Copyright © 2017 Urbica. All rights reserved.
//

import UIKit

class AddressPointViewController: UIViewController, AddressPointViewInput {

    var output: AddressPointViewOutput!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        AddressPointModuleConfigurator().configureModuleForViewInput(viewInput: self)
        output.viewIsReady()
    }


    // MARK: AddressPointViewInput
    func setupInitialState() {
    }
}
