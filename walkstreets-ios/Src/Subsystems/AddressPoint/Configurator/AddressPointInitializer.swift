//
//  AddressPointAddressPointInitializer.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 04/05/2017.
//  Copyright © 2017 Urbica. All rights reserved.
//

import UIKit

class AddressPointModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var viewController: AddressPointViewController!

    override func awakeFromNib() {

        let configurator = AddressPointModuleConfigurator()
        configurator.configureModuleForViewInput(viewController)
    }

}
