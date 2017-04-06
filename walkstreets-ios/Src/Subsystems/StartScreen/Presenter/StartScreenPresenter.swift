//
//  StartScreenPresenter.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 05/04/2017.
//  Copyright © 2017 Roman Ustiantcev. All rights reserved.
//


class StartScreenPresenter: StartScreenViewOutput {
    
    weak var view: StartScreenViewController!
    
    func viewIsReady() {
        
    }
    
    func openRouteCreation() {
        view.performSegue(withIdentifier: StartScreenConstants.routeScreenID, sender: nil)
    }
}
