//
//  AddressSearchAddressSearchPresenter.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 04/05/2017.
//  Copyright © 2017 Urbica. All rights reserved.
//

import MapKit

class AddressSearchPresenter: AddressSearchModuleInput, AddressSearchViewOutput, AddressSearchInteractorOutput{

    weak var view: AddressSearchViewInput!
    var interactor: AddressSearchInteractorInput!
    var router: AddressSearchRouterInput!
    var region = MKCoordinateRegion()
    
    var matchingItems: NSArray? {
        didSet {
            view.reloadData()
        }
    }

    
    func viewIsReady() {
        region.span.latitudeDelta = 0.001
        region.span.longitudeDelta = 0.001
        region.center = RouteCreationModuleConstants.moscowCenterCoordinate
    }
    
    func searchTextChanged(text: String) {

        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = text
        request.region = region
        let search = MKLocalSearch(request: request)
        search.start { [weak self] response, _ in
            guard let response = response else {
                return
            }
            self?.matchingItems = NSArray(array: response.mapItems)
        }
    }
    
    func clearData() {
        matchingItems = []
    }
    
    func actionBack() {
        router.actionBack()
    }
    
    func pointAddress(index: Int) {
        router.pointAddress(selectedItem: (matchingItems?[index] as? MKMapItem)!)
    }
    
    func pointOnMap() {
        router.pointOnMap()
    }
}
