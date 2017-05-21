//
//  AddressPointAddressPointRouter.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 04/05/2017.
//  Copyright © 2017 Urbica. All rights reserved.
//

class AddressPointRouter: AddressPointRouterInput {

    weak var view: AddressPointViewController?
    
    func dismiss() {
        view?.dismiss(animated: true, completion: nil)
        _ = view?.navigationController?.popViewController(animated: true)
    }
    
    
}
