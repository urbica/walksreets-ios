//
//  AddressSearchAddressSearchProtocols.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 04/05/2017.
//  Copyright © 2017 Urbica. All rights reserved.
//

import MapKit

protocol AddressSearchViewInput: class {

    func setupInitialState()
    func reloadData()
}

protocol AddressSearchViewOutput {
    
    var matchingItems: NSArray? {get}
    
    func viewIsReady()
    func actionBack()
    func clearData()
    func searchTextChanged(text: String)
    func pointAddress(index: Int)
    func pointOnMap()
}

protocol AddressSearchModuleInput: class {

}

protocol AddressSearchInteractorInput {

}

protocol AddressSearchInteractorOutput: class {

}

protocol AddressSearchRouterInput {
    func actionBack()
    func pointAddress(selectedItem: MKMapItem)
    func pointOnMap()
}
