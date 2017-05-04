//
//  AddressSearchAddressSearchPresenter.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 04/05/2017.
//  Copyright © 2017 Urbica. All rights reserved.
//

class AddressSearchPresenter: AddressSearchModuleInput, AddressSearchViewOutput, AddressSearchInteractorOutput{

    weak var view: AddressSearchViewInput!
    var interactor: AddressSearchInteractorInput!
    var router: AddressSearchRouterInput!

    func viewIsReady() {

    }
    
    func actionBack() {
        router.actionBack()
    }
}
