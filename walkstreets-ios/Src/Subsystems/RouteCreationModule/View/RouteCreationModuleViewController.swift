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
    var selectedPriorityIndex: Int?
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
        selectedPriorityIndex = index
    }
    
    func updateSelectedTime(index: Int) {
        for label in timeLabels {
            label.font = UIFont(name: "VremenaGroteskBook", size: 17)
        }
        
        for view in selectedTimeViews {
            view.backgroundColor = UIColor.white
        }
        
        self.selectedTimeViews[index].backgroundColor = UIColor.black
        self.timeLabels[index].font = UIFont(name: "VremenaGroteskMedium", size: 17)
        self.selectedTimeIndex = index
    }
    
}

extension RouteCreationModuleViewController {
    // MARK : actions
    
    @IBAction func actionFindUserLocation(sender: AnyObject) {
    
    }
    
    @IBAction func actionSelectTime(sender: UIButton) {
        updateSelectedTime(index: sender.tag)
    }
    
    @IBAction func actionSelectRoutePriority(sender: UIButton) {
        updatePriorityViews(index: sender.tag)
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
