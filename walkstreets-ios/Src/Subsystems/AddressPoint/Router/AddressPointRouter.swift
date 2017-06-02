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
        if let controllers = self.view?.navigationController?.viewControllers {
            view?.navigationController?.popToViewController(controllers[0], animated: true)
        }
    }
    
    
}
