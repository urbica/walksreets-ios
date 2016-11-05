//
//  RouteCreationModuleRouteCreationModuleViewController.swift
//  walkstreets-ios
//
//  Created by Roman Ustuantsev on 05/11/2016.
//  Copyright © 2016 Urbica. All rights reserved.
//

import UIKit

class RouteCreationModuleViewController: UIViewController, RouteCreationModuleViewInput {

    var output: RouteCreationModuleViewOutput!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        RouteCreationModuleModuleConfigurator().configureModuleForViewInput(viewInput: self)
        output.viewIsReady()
    }


    // MARK: RouteCreationModuleViewInput
    func setupInitialState() {
    }
}
