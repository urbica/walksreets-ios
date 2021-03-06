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
    @IBOutlet weak var lengthTimeLabel: UILabel!
    @IBOutlet var priorityViews: Array<CustomizableView>!
    @IBOutlet var priorityLabels: Array<UILabel>!
    @IBOutlet var legendsArray: Array<UIImageView>!
    @IBOutlet weak var centerUserView: UIView!
    @IBOutlet weak var prioritiesHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var userLocationConstraint: NSLayoutConstraint!
    
    var output: AddressPointViewOutput!
    var selectedItem: MKMapItem?
    var selectedPriorityIndex: Int? = 0
    let startPoint = MGLPointAnnotation()
    var endPoint = MGLPointAnnotation()
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        AddressPointModuleConfigurator().configureModuleForViewInput(viewInput: self)
        output.viewIsReady()
        setupInitialState()
    }
    
    
    // MARK: AddressPointViewInput
    func setupInitialState() {
        lengthTimeLabel.isHidden = true
        setupMap()
        let userLocation = Location.core.getCoordinate()
        
        if let placemark = selectedItem?.placemark {
            let firstPoint = CLLocationCoordinate2D(latitude: userLocation.latitude, longitude: userLocation.longitude)
            let lastPoint = CLLocationCoordinate2D(latitude: (placemark.coordinate.latitude), longitude: (placemark.coordinate.longitude))
            self.startPoint.coordinate = firstPoint
            endPoint.coordinate = lastPoint
            output.drawRoutsForPoints(firstPoint: startPoint.coordinate, lastPoint: lastPoint)
            
        }
    }
    
    func updateMap() {
        
        if let annotations = mapView.annotations {
            mapView.removeAnnotations(annotations)
        }
        
        if let layer = mapView.style?.layer(withIdentifier: "customLine") {
            mapView.style?.removeLayer(layer)
        }
        
        if let source = mapView.style?.source(withIdentifier: "customLine") {
            mapView.style?.removeSource(source)
        }
        
        let lastPoint = endPoint.coordinate
        
        output.drawRoutsForPoints(firstPoint: self.startPoint.coordinate, lastPoint: lastPoint)
    }
    
    func setupPoints(firstPoint: CLLocationCoordinate2D, lastPoint: CLLocationCoordinate2D) {
        
        startPoint.coordinate = firstPoint
        mapView.addAnnotation(startPoint)
        
        endPoint.coordinate = lastPoint
        mapView.addAnnotation(endPoint)
        
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
    
    func updatePriorityViews(index: Int) {
        for label in priorityLabels {
            label.textColor = UIColor.black
        }
        
        for view in priorityViews {
            view.backgroundColor = UIColor.clear
        }
        
        for legend in legendsArray {
            legend.isHidden = true
        }
        
        self.legendsArray[index].isHidden = false
        
        self.priorityViews[index].backgroundColor = UIColor.black
        self.priorityLabels[index].textColor = UIColor.white
        selectedPriorityIndex = index
        
        for view in priorityViews {
            view.isUserInteractionEnabled = false
        }
        
        
        if let annotations = mapView.annotations {
            mapView.removeAnnotations(annotations)
        }
        
        if let layer = mapView.style?.layer(withIdentifier: "customLine") {
            mapView.style?.removeLayer(layer)
        }
        
        if let source = mapView.style?.source(withIdentifier: "customLine") {
            mapView.style?.removeSource(source)
        }
        
        
        output.selectRouteAtIndex(index: index)
    }
    
    func hidePriorityViews() {
        prioritiesHeightConstraint.constant = 0
        userLocationConstraint.constant = 100
        
        UIView.animate(withDuration: 0.3, animations: { 
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}

extension AddressPointViewController {
    // MARK: actions
    
    @IBAction func actionClose(sender: AnyObject) {
        
        if let layer = mapView.style?.layer(withIdentifier: "customLine") {
            mapView.style?.removeLayer(layer)
        }
        
        if let source = mapView.style?.source(withIdentifier: "customLine") {
            mapView.style?.removeSource(source)
        }
        
        output.dismiss()
    }
    
    @IBAction func actionSelectRoutePriority(sender: UIButton) {
        updatePriorityViews(index: sender.tag)
    }
    
    @IBAction func actionGo(sender: AnyObject) {
        mapView.setZoomLevel(17.0, animated: true)
        mapView.setUserTrackingMode(.followWithHeading, animated: true)
        hidePriorityViews()
    }
    
    @IBAction func actionCenterOnUser(sender: AnyObject) {
        mapView.setCenter(Location.core.getCoordinate(), animated: true)
    }
}
