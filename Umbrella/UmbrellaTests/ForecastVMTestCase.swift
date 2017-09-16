//
//  ForecastVMTestCase.swift
//  Umbrella
//
//  Created by User on 9/15/17.
//  Copyright © 2017 DemetrioPerez. All rights reserved.
//

import XCTest
@testable import Umbrella

class ForecastVMTestCase: XCTestCase {
    var forecast:Forecast?
    var fVM:ForecastVM?
    override func setUp() {
        super.setUp()
        forecast = Forecast(temperature: 61, time: "lol", weather: "Sunny")
        fVM = ForecastVM( forecast!)

    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testHot()
    {
        XCTAssert((fVM?.isHot)!)
    }
    
    func testIsCold()  {
        XCTAssertFalse(!(fVM?.isHot)!)
    }
    
    func testSunny()
    {
        XCTAssertEqual(fVM?.weather.rawValue, "Sunny")
    }
    
    
}
