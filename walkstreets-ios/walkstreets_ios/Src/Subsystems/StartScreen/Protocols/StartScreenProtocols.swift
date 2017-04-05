//
//  StartScreenStartScreenProtocols.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 05/04/2017.
//  Copyright © 2017 Urbica. All rights reserved.
//

protocol StartScreenViewInput: class {

    func setupInitialState()
}

protocol StartScreenViewOutput {

    func viewIsReady()
}
