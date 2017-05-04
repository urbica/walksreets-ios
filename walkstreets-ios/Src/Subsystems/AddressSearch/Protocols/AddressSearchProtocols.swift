//
//  AddressSearchAddressSearchProtocols.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 04/05/2017.
//  Copyright © 2017 Urbica. All rights reserved.
//

protocol AddressSearchViewInput: class {

    func setupInitialState()
}

protocol AddressSearchViewOutput {

    func viewIsReady()
    func actionBack()
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
