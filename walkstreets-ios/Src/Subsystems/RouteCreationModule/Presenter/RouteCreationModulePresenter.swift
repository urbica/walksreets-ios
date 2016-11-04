//
//  RouteCreationModuleRouteCreationModulePresenter.swift
//  walkstreets-ios
//
//  Created by Roman Ustuantsev on 05/11/2016.
//  Copyright © 2016 Urbica. All rights reserved.
//

class RouteCreationModulePresenter: RouteCreationModuleModuleInput, RouteCreationModuleViewOutput, RouteCreationModuleInteractorOutput{

    weak var view: RouteCreationModuleViewInput!
    var interactor: RouteCreationModuleInteractorInput!
    var router: RouteCreationModuleRouterInput!

    func viewIsReady() {

    }
}
