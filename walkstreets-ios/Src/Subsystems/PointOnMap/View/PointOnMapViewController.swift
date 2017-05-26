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
            view.backgroundColor = UIColor.white
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
    
    @IBAction func actionPoint(sender: AnyObject) {
       updateMap()
    }
    
    @IBAction func actionSelectRoutePriority(sender: UIButton) {
        updatePriorityViews(index: sender.tag)
    }
}

extension PointOnMapViewController: MGLMapViewDelegate {
    
    func updateRouteView(route: AnyObject) {
        if let route = route as? Route {
            
            guard let length = route.length , let time = route.time else {return}
            
            if let sw = route.sw, let ne = route.ne {
                let bounds = MGLCoordinateBoundsMake(sw, ne)
                mapView.setVisibleCoordinateBounds(bounds, animated: false)
            }
            
            self.lengthTimeLabel.text = "\(length.roundTo(places: 2)) km • \(time) min"
        }
    }
    
    func showRoute(polyline: AnyObject) {
        if let polyline = polyline as? [CustomAnnotation] {
            mapView.add(polyline)
        }
        
        setupLastPoint(lastPoint: lastPoint.coordinate)
        
        for (index, view) in priorityViews.enumerated() {
            
            if index == selectedPriorityIndex {
                priorityViews[index].isUserInteractionEnabled = false
            }
            
            view.isUserInteractionEnabled = true
        }
    }
    
    func drawFirstLine(polyline: AnyObject) {
        priorityViewsHeightConstraint.constant = 182
        
        UIView.animate(withDuration: 0.3) { 
            self.view.layoutIfNeeded()
        }
        
        if let polyline = polyline as? MGLMultiPolyline {
            
            guard let style = mapView.style else { return }
            let source = MGLShapeSource(identifier: "customLine", shape: polyline, options: nil)
            style.addSource(source)
            
            let layer = MGLLineStyleLayer(identifier: "customLine", source: source)
            layer.lineJoin = MGLStyleValue(rawValue: NSValue(mglLineJoin: .round))
            layer.lineCap = MGLStyleValue(rawValue: NSValue(mglLineCap: .round))
            layer.lineWidth = MGLStyleValue(interpolationMode: .exponential,
                                            cameraStops: [14: MGLStyleValue<NSNumber>(rawValue: 5.5),
                                                          18: MGLStyleValue<NSNumber>(rawValue: 5.5)],
                                            options: [.defaultValue : MGLConstantStyleValue<NSNumber>(rawValue: 1.5)])
            if let color = RouteCreationModuleConstants.colorForBackground(index: selectedPriorityIndex!) {
                layer.lineColor = MGLStyleValue(rawValue: color)
            }
            style.insertLayer(layer, at: 262)
            mapView.add(polyline)
        }
    }
    
    func mapView(_ mapView: MGLMapView, strokeColorForShapeAnnotation annotation: MGLShape) -> UIColor {
        
        if let annotation = annotation as? CustomAnnotation {
            return annotation.color ?? .orange
        } else {
            return UIColor(hex: "1000FF")
        }
    }
    
    func mapView(_ mapView: MGLMapView, lineWidthForPolylineAnnotation annotation: MGLPolyline) -> CGFloat {
        
        if let annotationWidth = (annotation as? CustomAnnotation)?.width {
            return annotationWidth
        }
        
        return 5.5
    }
    
    func mapView(_ mapView: MGLMapView, alphaForShapeAnnotation annotation: MGLShape) -> CGFloat {
        return 1.0
    }
    
    func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
        let endPointCoordinate = self.lastPoint.coordinate
        
        if annotation.coordinate.latitude == endPointCoordinate.latitude && annotation.coordinate.longitude == endPointCoordinate.longitude {
            let image = UIImage(named: "endPoint")!
            return DraggableAnnotationView(reuseIdentifier: "endPoint", size: 50, image: image)
        }
        return nil
    }
    
}
