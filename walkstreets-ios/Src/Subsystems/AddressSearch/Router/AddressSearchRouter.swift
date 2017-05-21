//
//  AddressSearchAddressSearchRouter.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 04/05/2017.
//  Copyright © 2017 Urbica. All rights reserved.
//

import MapKit

class AddressSearchRouter: AddressSearchRouterInput {

    weak var view: AddressSearchViewController?
    
    func actionBack() {
        view?.navigationController?.popViewController(animated: true)
    }
    
    func pointAddress(selectedItem: MKMapItem) {
        view?.performSegue(withIdentifier: "toAddressPoint", sender: selectedItem)
    }
    
}
