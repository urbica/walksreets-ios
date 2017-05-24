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
    @IBOutlet weak var lengthTimeLabel: UILabel!
    @IBOutlet var priorityViews: Array<CustomizableView>!
    @IBOutlet var priorityLabels: Array<UILabel>!
    
    var output: AddressPointViewOutput!
    var selectedItem: MKMapItem?
    var selectedPriorityIndex: Int? = 0
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
        if let address = parseAddress(selectedItem: selectedItem?.placemark) {
            addressLabel.text = address
        }
        
        setupMap()
        let userLocation = Location.core.getCoordinate()
        
        if let placemark = selectedItem?.placemark {
            let firstPoint = CLLocationCoordinate2D(latitude: userLocation.latitude, longitude: userLocation.longitude)
            let lastPoint = CLLocationCoordinate2D(latitude: (placemark.coordinate.latitude), longitude: (placemark.coordinate.longitude))
            endPoint.coordinate = lastPoint
            output.drawRoutsForPoints(firstPoint: firstPoint, lastPoint: lastPoint)
            
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
        
        let userLocation = Location.core.getCoordinate()
        let firstPoint = CLLocationCoordinate2D(latitude: userLocation.latitude, longitude: userLocation.longitude)
        let lastPoint = endPoint.coordinate
        
        output.drawRoutsForPoints(firstPoint: firstPoint, lastPoint: lastPoint)
    }
    
    func setupPoints(firstPoint: CLLocationCoordinate2D, lastPoint: CLLocationCoordinate2D) {
        
        let startPoint = MGLPointAnnotation()
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
            view.backgroundColor = UIColor.white
        }
        
        self.priorityViews[index].backgroundColor = UIColor.black
        self.priorityLabels[index].textColor = UIColor.white
        selectedPriorityIndex = index
        
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
}

extension AddressPointViewController: MGLMapViewDelegate {
    
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
    
    func showRouteAtIndex(index: Int) {
    
    }
    
    func showRoute(polyline: AnyObject) {
        if let polyline = polyline as? [CustomAnnotation] {
            mapView.add(polyline)
        }
        
        let userLocation = Location.core.getCoordinate()
        
        let firstPoint = CLLocationCoordinate2D(latitude: userLocation.latitude, longitude: userLocation.longitude)
        
        setupPoints(firstPoint: firstPoint, lastPoint: self.endPoint.coordinate)
    }
    
    func drawFirstLine(polyline: AnyObject) {
        
        if let polyline = polyline as? MGLMultiPolyline {
            
            guard let style = self.mapView.style else { return }
            let source = MGLShapeSource(identifier: "customLine", shape: polyline, options: nil)
            style.addSource(source)
            
            let layer = MGLLineStyleLayer(identifier: "customLine", source: source)
            layer.lineJoin = MGLStyleValue(rawValue: NSValue(mglLineJoin: .round))
            layer.lineCap = MGLStyleValue(rawValue: NSValue(mglLineCap: .round))
            layer.lineWidth = MGLStyleValue(interpolationMode: .exponential,
                                            cameraStops: [14: MGLStyleValue<NSNumber>(rawValue: 5.5),
                                                          18: MGLStyleValue<NSNumber>(rawValue: 20)],
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
        
        let userLocation = Location.core.getCoordinate()
        let endPointCoordinate = self.endPoint.coordinate
        
        if annotation.coordinate.latitude == userLocation.latitude && annotation.coordinate.longitude == userLocation.longitude {
            let image = UIImage(named: "startPoint")!
            let drag = DraggableAnnotationView(reuseIdentifier: "startPoint", size: 40, image: image)
            drag.isDraggable = false
            return drag
            
        } else if annotation.coordinate.latitude == endPointCoordinate.latitude && annotation.coordinate.longitude == endPointCoordinate.longitude {
            
            let image = UIImage(named: "endPoint")!
            return DraggableAnnotationView(reuseIdentifier: "endPoint", size: 40, image: image)
        }
        return nil
    }
    
}
