//
//  DraggableAnnotation.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 24/05/2017.
//  Copyright © 2017 Roman Ustiantcev. All rights reserved.
//

import Foundation
import Mapbox

class DraggableAnnotationView: MGLAnnotationView {
    
    
    init(reuseIdentifier: String, size: CGFloat, image: UIImage, pointOnMap: Bool? = true) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        isDraggable = true
        centerOffset = CGVector(dx: 0, dy: -35)
        scalesWithViewingDistance = false
        
        
        frame = CGRect(x: 0, y: 0, width: 47, height: size)
        layer.contents = image.cgImage

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setDragState(_ dragState: MGLAnnotationViewDragState, animated: Bool) {
        super.setDragState(dragState, animated: animated)
        
        switch dragState {
        case .starting:
            print("Starting", terminator: "")
            startDragging()
        case .dragging:
            print(".", terminator: "")
        case .ending, .canceling:
            print("Ending")
            endDragging()
        case .none:
            return
        }
    }
    
    func startDragging() {
        UIView.animate(withDuration: 0.0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            self.layer.opacity = 0.8
            self.transform = CGAffineTransform.identity.scaledBy(x: 1.5, y: 1.5)
        }, completion: nil)
    }
    
    func endDragging() {
        transform = CGAffineTransform.identity.scaledBy(x: 1.5, y: 1.5)
        UIView.animate(withDuration: 0.0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            self.layer.opacity = 1
            self.transform = CGAffineTransform.identity.scaledBy(x: 1, y: 1)
        }, completion: { _ in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: AddressPointConstants.kPointUpdated), object: nil)
        })
    }
}
