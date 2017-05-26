//
//  PointOnMapPointOnMapViewController.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 26/05/2017.
//  Copyright © 2017 Urbica. All rights reserved.
//

import UIKit
import Mapbox

class PointOnMapViewController: UIViewController, PointOnMapViewInput {

    @IBOutlet weak var mapView: MGLMapView!
    
    var output: PointOnMapViewOutput!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        PointOnMapModuleConfigurator().configureModuleForViewInput(viewInput: self)
        output.viewIsReady()
        setupInitialState()
    }


    // MARK: PointOnMapViewInput
    func setupInitialState() {
        setupMap()
        
    }
    
    func setupMap() {
        
        mapView.delegate = self
        mapView.showsUserLocation = true
        let userLocation = Location.core.getCoordinate()
        
        if userLocation.latitude == 0.0 {
            mapView.setCenter(RouteCreationModuleConstants.moscowCenterCoordinate, animated: false)
        } else {
            mapView.setCenter(userLocation, zoomLevel: 13, animated: false)
        }
        
        mapView.tintColor = UIColor(hex: "#1000ff")
        mapView.compassView.isHidden = true
        
        // Double tap later
        //setupTapMap()
    }
}

extension PointOnMapViewController {
    // MARK: actions
    
    @IBAction func actionBack(senderL: AnyObject) {
        output.dismiss()
    }
    
    @IBAction func actionPoint(sender: AnyObject) {
        
    }
}

extension PointOnMapViewController: MGLMapViewDelegate {
    
}
