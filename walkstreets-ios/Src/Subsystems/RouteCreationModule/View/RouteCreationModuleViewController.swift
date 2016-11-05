//
//  RouteCreationModuleRouteCreationModuleViewController.swift
//  walkstreets-ios
//
//  Created by Roman Ustuantsev on 05/11/2016.
//  Copyright © 2016 Urbica. All rights reserved.
//

import UIKit
import Mapbox

class RouteCreationModuleViewController: UIViewController, RouteCreationModuleViewInput {
    
    // main view
    @IBOutlet weak var mapView: UIView!
    
    // route details
    @IBOutlet weak var routeDetailsView: UIView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var locationTypeLabel: UILabel!
    
    // route settings
    @IBOutlet weak var routeSettingsView: UIView!
    
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var routeTimerStackView: UIStackView!
    
    
    
    var output: RouteCreationModuleViewOutput!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        RouteCreationModuleModuleConfigurator().configureModuleForViewInput(viewInput: self)
        output.viewIsReady()
        setupInitialState()
    }


    // MARK: RouteCreationModuleViewInput
    func setupInitialState() {
        
    }
}

extension RouteCreationModuleViewController {
    // MARK : actions
    
    @IBAction func actionFindUserLocation(sender: AnyObject) {
    
    }

    @IBAction func actionCloseRoutedetailsView(sender: AnyObject) {
        
    }
    
    @IBAction func actionShowCloseRouteSettings(sender: AnyObject) {
        
    }
    
    @IBAction func actionStartroute(sender: AnyObject) {
        
    }
    
    @IBAction func actionEditRoute(sender: AnyObject) {
        
    }
    
}
