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
    @IBOutlet var legendsArray: Array<UIImageView>!
    @IBOutlet weak var userLocationView: UIView!
    @IBOutlet weak var userLocationConstraint: NSLayoutConstraint!
    
    var output: PointOnMapViewOutput!
    let lastPoint = MGLPointAnnotation()
    let location = Location.core.getCoordinate()
    var selectedPriorityIndex: Int? = 0
    let manager = CLLocationManager()


    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        PointOnMapModuleConfigurator().configureModuleForViewInput(viewInput: self)
        output.viewIsReady()
        setupInitialState()
    }


    // MARK: PointOnMapViewInput
    func setupInitialState() {
        manager.delegate = self
        manager.startUpdatingHeading()
        lengthTimeLabel.isHidden = true
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
        
        self.lastPoint.coordinate.latitude = lastPoint.latitude + 0.0001
        self.lastPoint.coordinate.longitude = lastPoint.longitude + 0.0001
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
        priorityViewsHeightConstraint.constant = 0
        userLocationConstraint.constant = 100
        
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
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
        mapView.setZoomLevel(17.0, animated: true)
        mapView.setUserTrackingMode(.followWithHeading, animated: true)
        hidePriorityViews()
    }
    
    @IBAction func actionCenterOnUser(sender: AnyObject) {
        mapView.setCenter(Location.core.getCoordinate(), animated: true)
    }
}

extension PointOnMapViewController: CLLocationManagerDelegate {
//    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
//        
//        // Convert Degree to Radian and move the needle
//        let newRad =  -newHeading.trueHeading * Double.pi / 180.0
//        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseInOut, animations: { 
//            self.compassImageView.transform = CGAffineTransform(rotationAngle: CGFloat(newRad))
//            self.view.layoutIfNeeded()
//            self.view.layoutSubviews()
//        }, completion: nil)
//        
//        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: { 
//            
//        }, completion: nil)
//    }
}
