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
    
    // priority views
    @IBOutlet var priorityViews: Array<CustomizableView>!
    @IBOutlet var priorityLabels: Array<UILabel>!
    
    
    
    var output: RouteCreationModuleViewOutput!
    var selectedPriorityIndex: Int? = 0
    var selectedTimeIndex: Int?
    
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
    
    func updatePriorityViews(index: Int) {
        for label in priorityLabels {
            label.textColor = UIColor.black
        }
        
        for view in priorityViews {
            view.backgroundColor = UIColor.white
        }
        
        self.priorityViews[index].backgroundColor = UIColor.black
        self.priorityLabels[index].textColor = UIColor.white
        
        
        for view in priorityViews {
            if view.isUserInteractionEnabled == false {
                view.isUserInteractionEnabled = true
            }
        }
        
        self.priorityViews[index].isUserInteractionEnabled = false
        
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
    
    func updateSelectedTime(index: Int) {
        for label in timeLabels {
            label.font = UIFont(name: "VremenaGroteskBook", size: 17)
        }
        
        for view in selectedTimeViews {
            view.backgroundColor = UIColor.white
        }
        
        for label in priorityLabels {
            label.textColor = UIColor.black
        }
        
        for view in priorityViews {
            view.backgroundColor = UIColor.white
        }
        
        if let priority = selectedPriorityIndex {
        
            self.priorityViews[priority].backgroundColor = UIColor.black
            self.priorityLabels[priority].textColor = UIColor.white
            output.routeIndex = priority
        }
        
        self.selectedTimeViews[index].backgroundColor = UIColor.black
        self.timeLabels[index].font = UIFont(name: "VremenaGroteskMedium", size: 17)
        self.selectedTimeIndex = index
        
        output.walkMeAround(time: index)
        routeTimeView.isUserInteractionEnabled = false

        if let annotations = mapView.annotations {
            mapView.removeAnnotations(annotations)
        }
        
        if let layer = mapView.style?.layer(withIdentifier: "customLine") {
            mapView.style?.removeLayer(layer)
        }
        
        if let source = mapView.style?.source(withIdentifier: "customLine") {
            mapView.style?.removeSource(source)
        }
        
    }
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
    }
}

extension RouteCreationModuleViewController {
    // MARK : actions
    
    @IBAction func actionSelectTime(sender: UIButton) {
        updateSelectedTime(index: sender.tag)
    }
    
    @IBAction func actionSelectRoutePriority(sender: UIButton) {
        updatePriorityViews(index: sender.tag)
    }

    @IBAction func actionRouteDetailsView(sender: AnyObject) {
        output.walkMeAround(time: 0)
    }
    
    @IBAction func closeRouteDetailsView(sender: AnyObject) {
        hideRouteViews()
    }
    
    @IBAction func actionOpenSearch(sender: AnyObject) {
        output.openSearch()
    }
    
    @IBAction func actionOpenAbout(sender: AnyObject) {
        output.openAbout()
    }
}
