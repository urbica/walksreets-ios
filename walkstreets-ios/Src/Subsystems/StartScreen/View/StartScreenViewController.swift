//
//  StartScreenViewController.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 05/04/2017.
//  Copyright © 2017 Roman Ustiantcev. All rights reserved.
//

import UIKit
import MapKit

class StartScreenViewController: UIViewController, StartScreenViewInput {
    
    @IBOutlet weak var locationButton: UIButton!
    
    var output: StartScreenViewOutput!
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        StartScreenModuleConfigurator().configureModuleForViewInput(viewInput: self)
        output.viewIsReady()
        setupInitialState()
    }
    
    
    // MARK: StartScreenViewInput
    func setupInitialState() {
        
        let status = CLLocationManager.authorizationStatus()
        if status == .denied || status == .restricted || status == .notDetermined {
            locationButton.setTitleColor(UIColor.black, for: .disabled)
            locationButton.isEnabled = true
        } else {
            locationButton.setTitleColor(UIColor.gray, for: .disabled)
            locationButton.isEnabled = false
        }
    }
    
    func initLocationManager() {
        _ = Location.core.getCoordinate()
        locationButton.isEnabled = false
        locationButton.setTitleColor(UIColor.gray, for: .disabled)
        output.openRouteCreation()
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
