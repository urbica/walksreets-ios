//
//  AddressPointAddressPointViewController.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 04/05/2017.
//  Copyright © 2017 Urbica. All rights reserved.
//

import UIKit
import Mapbox
import MapKit

class AddressPointViewController: UIViewController, AddressPointViewInput {

    @IBOutlet weak var mapView: MGLMapView!
    @IBOutlet weak var addressLabel: UILabel!
    
    var output: AddressPointViewOutput!
    var selectedItem: MKMapItem?

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        AddressPointModuleConfigurator().configureModuleForViewInput(viewInput: self)
        output.viewIsReady()
        setupInitialState()
    }


    // MARK: AddressPointViewInput
    func setupInitialState() {
        if let address = parseAddress(selectedItem: selectedItem?.placemark) {
            addressLabel.text = address
        }
        
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
    
    func parseAddress(selectedItem:MKPlacemark?) -> String? {
        let firstSpace = (selectedItem?.subThoroughfare != nil && selectedItem?.thoroughfare != nil) ? " " : ""
        // put a comma between street and city/state
        let addressLine = String(
            format:"%@%@%@",
            // street number
            selectedItem?.subThoroughfare ?? "",
            firstSpace,
            // street name
            selectedItem?.thoroughfare ?? ""
        )
        return addressLine
    }
}

extension AddressPointViewController {
    // MARK: actions
    
    @IBAction func actionClose(sender: AnyObject) {
        output.dismiss()
    }
}

extension AddressPointViewController: MGLMapViewDelegate {
    
}
