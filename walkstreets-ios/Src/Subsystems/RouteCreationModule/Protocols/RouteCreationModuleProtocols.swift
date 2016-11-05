//
//  RouteCreationModuleRouteCreationModuleProtocols.swift
//  walkstreets-ios
//
//  Created by Roman Ustuantsev on 05/11/2016.
//  Copyright © 2016 Urbica. All rights reserved.
//

import UIKit
import Foundation

protocol RouteCreationModuleViewInput: class {
    func setupInitialState()
    func openRouteDetailsView()
}

protocol RouteCreationModuleViewOutput {
    func configureRoute(latitude: Double, longitude: Double)
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
