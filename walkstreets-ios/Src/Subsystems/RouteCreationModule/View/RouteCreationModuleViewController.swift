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
    
    // start route view
    @IBOutlet weak var startRouteView: UIView!
    
    
    // route time views
    @IBOutlet weak var routeTimeView: UIView!
    @IBOutlet var timeLabels: Array<UILabel>!
    @IBOutlet var selectedTimeViews: Array<UIView>!
    @IBOutlet var timeButtons: Array<UIButton>!
    @IBOutlet weak var timeViewHeightConstraint: NSLayoutConstraint!
    
    // route detail view
    @IBOutlet weak var routeDetailsView: UIView!
    @IBOutlet weak var lengthTimeLabel: UILabel!
    @IBOutlet weak var routeDetailsHeightConstraint: NSLayoutConstraint!
    
    
    
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
        timeViewHeightConstraint.constant = 0
        
        routeTimeView.isHidden = true
        routeDetailsView.isHidden = true
        setupMap()
    }
    
}

extension RouteCreationModuleViewController {
    // MARK : actions
    
    @IBAction func actionFindUserLocation(sender: AnyObject) {
    
    }

    @IBAction func actionRouteDetailsView(sender: AnyObject) {
        showRouteViews()
    }
    
    @IBAction func closeRouteDetailsView(sender: AnyObject) {
        hideRouteViews()
    }
    
    
    @IBAction func actionEditRoute(sender: AnyObject) {
        locationArray.removeAll()
        if let annotaions = mapView.annotations {
            mapView.removeAnnotations(annotaions)
        }
    }
    
    
}
