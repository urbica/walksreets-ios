//
//  AddressSearchAddressSearchInitializer.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 04/05/2017.
//  Copyright © 2017 Urbica. All rights reserved.
//

import UIKit

class AddressSearchModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var viewController: AddressSearchViewController!

    override func awakeFromNib() {

        let configurator = AddressSearchModuleConfigurator()
        configurator.configureModuleForViewInput(viewController)
    }

}
