//
//  RouteCreationModuleRouteCreationModuleProtocols.swift
//  walkstreets-ios
//
//  Created by Roman Ustuantsev on 05/11/2016.
//  Copyright © 2016 Urbica. All rights reserved.
//

protocol RouteCreationModuleViewInput: class {

    func setupInitialState()
}

protocol RouteCreationModuleViewOutput {

    func viewIsReady()
}

protocol RouteCreationModuleModuleInput: class {

}

protocol RouteCreationModuleInteractorInput {

}

protocol RouteCreationModuleInteractorOutput: class {

}

protocol RouteCreationModuleRouterInput {

}
