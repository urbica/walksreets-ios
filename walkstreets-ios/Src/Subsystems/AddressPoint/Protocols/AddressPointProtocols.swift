//
//  AddressPointAddressPointProtocols.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 04/05/2017.
//  Copyright © 2017 Urbica. All rights reserved.
//

protocol AddressPointViewInput: class {

    func setupInitialState()
}

protocol AddressPointViewOutput {

    func viewIsReady()
    func dismiss()
}

protocol AddressPointModuleInput: class {

}

protocol AddressPointInteractorInput {

}

protocol AddressPointInteractorOutput: class {

}

protocol AddressPointRouterInput {
    func dismiss()
}
