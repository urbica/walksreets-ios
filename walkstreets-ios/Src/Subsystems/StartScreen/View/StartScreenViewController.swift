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
    @IBOutlet weak var forwardButton: UIButton!
    
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
        
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways, .authorizedWhenInUse:
            forwardButton.setTitleColor(UIColor.black, for: .normal)
            forwardButton.isEnabled = true
            locationButton.setTitleColor(UIColor.gray, for: .disabled)
            locationButton.isEnabled = false
        default:
            forwardButton.setTitleColor(UIColor.gray, for: .normal)
            forwardButton.isEnabled = false
            locationButton.setTitleColor(UIColor.black, for: .disabled)
            locationButton.isEnabled = true
        }
    }
    
    func initLocationManager() {
        _ = Location.core.getCoordinate()
        locationButton.isEnabled = false
        locationButton.setTitleColor(UIColor.gray, for: .disabled)
        
        forwardButton.setTitleColor(UIColor.black, for: .normal)
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
