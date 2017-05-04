//
//  AboutAboutProtocols.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 04/05/2017.
//  Copyright © 2017 Urbica. All rights reserved.
//

protocol AboutViewInput: class {

    func setupInitialState()
}

protocol AboutViewOutput {

    func viewIsReady()
}
