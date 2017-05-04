//
//  AddressSearchAddressSearchViewController.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 04/05/2017.
//  Copyright © 2017 Urbica. All rights reserved.
//

import UIKit

class AddressSearchViewController: UIViewController, AddressSearchViewInput {

    var output: AddressSearchViewOutput!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        AddressSearchModuleConfigurator().configureModuleForViewInput(viewInput: self)
        output.viewIsReady()
    }


    // MARK: AddressSearchViewInput
    func setupInitialState() {
    }
}

extension AddressSearchViewController {
    //MARK: actions
    
    @IBAction func actionBack(sender: AnyObject) {
        output.actionBack()
    }
}
