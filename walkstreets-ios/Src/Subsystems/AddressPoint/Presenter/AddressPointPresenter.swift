//
//  AddressPointAddressPointPresenter.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 04/05/2017.
//  Copyright © 2017 Urbica. All rights reserved.
//

class AddressPointPresenter: AddressPointModuleInput, AddressPointViewOutput, AddressPointInteractorOutput{

    weak var view: AddressPointViewInput!
    var interactor: AddressPointInteractorInput!
    var router: AddressPointRouterInput!

    func viewIsReady() {

    }
}
