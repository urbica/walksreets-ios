//
//  AddressSearchAddressSearchProtocols.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 04/05/2017.
//  Copyright © 2017 Urbica. All rights reserved.
//

import Foundation

protocol AddressSearchViewInput: class {

    func setupInitialState()
    func reloadData()
}

protocol AddressSearchViewOutput {
    
    var matchingItems: NSArray? {get}
    
    func viewIsReady()
    func actionBack()
    func searchTextChanged(text: String)
}

protocol AddressSearchModuleInput: class {

}

protocol AddressSearchInteractorInput {

}

protocol AddressSearchInteractorOutput: class {

}

protocol AddressSearchRouterInput {
    func actionBack()
}
