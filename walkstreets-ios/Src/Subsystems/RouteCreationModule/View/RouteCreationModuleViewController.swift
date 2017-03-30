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
    @IBOutlet weak var mapView: MGLMapView!
    
    // route details
    @IBOutlet weak var routeDetailsView: UIView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var locationTypeLabel: UILabel!
    @IBOutlet weak var routeDetailsHeightConstraint: NSLayoutConstraint!
    
    // route settings
    @IBOutlet weak var routeSettingsView: UIView!
    
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var routeTimerStackView: UIStackView!
    @IBOutlet weak var routeTypeView: UIView!
    @IBOutlet weak var routeTypeViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var regularRouteButton: UIButton!
    @IBOutlet weak var steplessRouteButton: UIButton!
    
    var output: RouteCreationModuleViewOutput!
    var routeType: String = "regular"
    var locationArray = [CLLocationCoordinate2D]()
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        RouteCreationModuleModuleConfigurator().configureModuleForViewInput(viewInput: self)
        output.viewIsReady()
        setupInitialState()
    }


    // MARK: RouteCreationModuleViewInput
    func setupInitialState() {
        routeDetailsHeightConstraint.constant = 0
        routeDetailsView.isHidden = true
        setupMap()
    }
    
    func configureRouteDetailsView(address: String, street: String) {
        addressLabel.text = address
        locationTypeLabel.text = street
    }
}

extension RouteCreationModuleViewController {
    // MARK : actions
    
    @IBAction func actionFindUserLocation(sender: AnyObject) {
    
    }

    @IBAction func actionCloseRoutedetailsView(sender: AnyObject) {
        if routeDetailsView.isHidden == false {
            closeRouteDetailsView()
        }
    }
    
    @IBAction func actionShowCloseRouteSettings(sender: AnyObject) {
        if routeTypeView.isHidden == true {
            openRouteTypeView()
        } else {
            closeRouteTypeView()
        }
    }
    
    @IBAction func actionStartroute(sender: AnyObject) {
        if routeDetailsView.isHidden == true {
            openRouteDetailsView()
            if locationArray.count == 2 {
                output.configureRouteDetailsWithEndPoint(endPoint: locationArray.first)
            }
        }
        
    }
    
    @IBAction func actionEditRoute(sender: AnyObject) {
        locationArray.removeAll()
        if let annotaions = mapView.annotations {
            mapView.removeAnnotations(annotaions)
        }
    }
    
    @IBAction func chooseRegularRoute(sender: AnyObject) {
        regularRouteButton.isHighlighted = true
        steplessRouteButton.isHighlighted = false
        routeType = "regular"
        setupMap()
    }
    
    @IBAction func chooseSteplessRoute(sender: AnyObject) {
        regularRouteButton.isHighlighted = false
        steplessRouteButton.isHighlighted = true
        routeType = "green"
        setupMap()
    }
}
