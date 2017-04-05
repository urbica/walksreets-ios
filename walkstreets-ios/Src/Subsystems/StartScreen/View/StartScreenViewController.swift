//
//  StartScreenViewController.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 05/04/2017.
//  Copyright © 2017 Roman Ustiantcev. All rights reserved.
//

import UIKit

class StartScreenViewController: UIViewController, StartScreenViewInput {
    
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    
    var output: StartScreenViewOutput!
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        StartScreenModuleConfigurator().configureModuleForViewInput(viewInput: self)
        output.viewIsReady()
    }
    
    
    // MARK: StartScreenViewInput
    func setupInitialState() {
        switch Location.core.checkIfEnabled() {
        case true:
            locationButton.isEnabled = false
        case false:
            forwardButton.isEnabled = true
        }
    }
    
    func initLocationManager() {
        _ = Location.core.getCoordinate()
        locationButton.isEnabled = false
        forwardButton.isEnabled = true
    }
    
}

extension StartScreenViewController {
    // MARK: actions
    
    @IBAction func actionInitLocation(sender: Any) {
        initLocationManager()
    }
    
    @IBAction func actionOpenRouteCreation(sender: Any) {
        output.openRouteCreation()
    }
    
}
