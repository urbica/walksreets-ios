//
//  walkstreets_iosTests.swift
//  walkstreets-iosTests
//
//  Created by Roman Ustiantcev on 10/12/2016.
//  Copyright © 2016 Roman Ustiantcev. All rights reserved.
//

import XCTest
import MapKit

@testable import walkstreets_ios

class walkstreets_iosTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGeocoder() {
        let presenter = RouteCreationModulePresenter()
        let endPoint = CLLocationCoordinate2D(latitude: 55.858920, longitude: 37.424645)
        let result = presenter.configureRouteDetailsWithEndPoint(endPoint: endPoint)
        
        XCTAssert(result, "Geocoder tested")
    }
    
    
}
