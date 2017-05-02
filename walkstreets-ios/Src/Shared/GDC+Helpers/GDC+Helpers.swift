//
//  GDC+Helpers.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 02/05/2017.
//  Copyright © 2017 Roman Ustiantcev. All rights reserved.
//

import Foundation

func makeDelayAfter(delay: Double, closure: @escaping ()->()) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
        DispatchQueue.main.async {
            closure()
        }
    }
}
