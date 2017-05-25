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
    var matchingItems: NSArray? {
        didSet {
            view.reloadData()
        }
    }

    
    func viewIsReady() {

    }
    
    func searchTextChanged(text: String) {
        let request = MKLocalSearchRequest()
        let span = MKCoordinateSpan(latitudeDelta: 0.00001, longitudeDelta: 0.00001)
        request.naturalLanguageQuery = text
        request.region = MKCoordinateRegion(center: RouteCreationModuleConstants.moscowCenterCoordinate, span: span)
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
}
