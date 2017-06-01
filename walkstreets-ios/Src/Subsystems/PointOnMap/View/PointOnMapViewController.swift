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
    @IBOutlet var priorityViews: Array<CustomizableView>!
    @IBOutlet var priorityLabels: Array<UILabel>!
    @IBOutlet weak var lengthTimeLabel: UILabel!
    @IBOutlet weak var priorityViewsHeightConstraint: NSLayoutConstraint!
    
    var output: PointOnMapViewOutput!
    let lastPoint = MGLPointAnnotation()
    let location = Location.core.getCoordinate()
    var selectedPriorityIndex: Int? = 0

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        PointOnMapModuleConfigurator().configureModuleForViewInput(viewInput: self)
        output.viewIsReady()
        setupInitialState()
    }


    // MARK: PointOnMapViewInput
    func setupInitialState() {
        priorityViewsHeightConstraint.constant = 0
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
        
        setupLastPoint(lastPoint: mapView.centerCoordinate)
        
        // Double tap later
        //setupTapMap()
    }
    
    func setupLastPoint(lastPoint: CLLocationCoordinate2D) {
        
        self.lastPoint.coordinate = lastPoint
        mapView.addAnnotation(self.lastPoint)
        
    }
    
    func showRouteAtIndex(index: Int) {
        
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
        
        let userLocation = Location.core.getCoordinate()
        let firstPoint = CLLocationCoordinate2D(latitude: userLocation.latitude, longitude: userLocation.longitude)
        let lastPoint = self.lastPoint.coordinate
        
        output.drawRoutsForPoints(firstPoint: firstPoint, lastPoint: lastPoint)
    }
    
    func updatePriorityViews(index: Int) {
        for label in priorityLabels {
            label.textColor = UIColor.black
        }
        
        for view in priorityViews {
            view.backgroundColor = UIColor.clear
        }
        
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
    
}

extension PointOnMapViewController {
    // MARK: actions
    
    @IBAction func actionBack(senderL: AnyObject) {
        output.dismiss()
    }
    
    @IBAction func actionSelectRoutePriority(sender: UIButton) {
        updatePriorityViews(index: sender.tag)
    }
    
    @IBAction func actionGo(sender: AnyObject) {
        mapView.setUserTrackingMode(.follow, animated: true)
    }
}
