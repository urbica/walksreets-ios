//
//  PointOnMapViewController+Maps.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 28/05/2017.
//  Copyright © 2017 Roman Ustiantcev. All rights reserved.
//

import Mapbox


extension PointOnMapViewController: MGLMapViewDelegate {
    
    func updateRouteView(route: AnyObject) {
        if let route = route as? Route {

            guard let length = route.length , let time = route.time else {return}
            
            if let sw = route.sw, let ne = route.ne {
                let bounds = MGLCoordinateBoundsMake(sw, ne)
                mapView.setVisibleCoordinateBounds(bounds, animated: false)
            }
            
            
            if let start = route.start {
                setupLastPoint(lastPoint: lastPoint.coordinate, firstPoint: start)
            } else {
                setupLastPoint(lastPoint: lastPoint.coordinate)
            }
            
            lengthTimeLabel.isHidden = false
            if time > 60 {
                self.lengthTimeLabel.text = "\(length.roundTo(places: 2)) KM • \(time / 60) H \(time % 60) MIN"
            } else {
                self.lengthTimeLabel.text = "\(length.roundTo(places: 2)) KM • \(time) MIN"
            }
            
        }
    }
    
    func showRoute(polyline: AnyObject) {
        if let polyline = polyline as? [CustomAnnotation] {
            mapView.add(polyline)
        }
        
        for (index, view) in priorityViews.enumerated() {
            
            if index == selectedPriorityIndex {
                priorityViews[index].isUserInteractionEnabled = false
            }
            
            view.isUserInteractionEnabled = true
        }
    }
    
    func drawFirstLine(polyline: AnyObject) {
        priorityViewsHeightConstraint.constant = 182
        userLocationView.isHidden = false
        //compassView.isHidden = false
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
        
        let startPoint = self.firstPointAnnotation.coordinate
        let endPointCoordinate = self.lastPoint.coordinate
        
        if annotation.coordinate.latitude == startPoint.latitude && annotation.coordinate.longitude == startPoint.longitude {
            let image = UIImage(named: "startPoint")!
            
            let drag = DraggableAnnotationView(reuseIdentifier: "startPoint", size: image.size.height, image: image, pointOnMap: false)
            return drag
            
        } else if annotation.coordinate.latitude == endPointCoordinate.latitude && annotation.coordinate.longitude == endPointCoordinate.longitude {
            let image = UIImage(named: "endPoint")!
            return DraggableAnnotationView(reuseIdentifier: "endPoint", size: image.size.height, image: image, pointOnMap: false)
        }
        return nil
    }
    
}
