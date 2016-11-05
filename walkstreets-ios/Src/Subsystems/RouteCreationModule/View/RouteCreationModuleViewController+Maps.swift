//
//  RouteCreationModuleViewController+Maps.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 05/11/2016.
//  Copyright © 2016 Roman Ustiantcev. All rights reserved.
//

import Mapbox

extension RouteCreationModuleViewController : MGLMapViewDelegate {
    
    func setupMap() {
        mapView.setCenter(RouteCreationModuleConstants.moscowCenterCoordinate, zoomLevel: 13, animated: false)
        mapView.compassView.isHidden = true
    }

}
