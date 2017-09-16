//
//  DayTestCase.swift
//  Umbrella
//
//  Created by User on 9/15/17.
//  Copyright © 2017 DemetrioPerez. All rights reserved.
//

import XCTest
@testable import Umbrella

class DayTestCase: XCTestCase {
    
    var forecast1:Forecast?
    var forecast2:Forecast?
    var forecast3:Forecast?
    var forecast4:Forecast?
    var day:DayViewModel?
    
    override func tearDown() {
        super.tearDown()
    }
    
    override func setUp() {
        
        forecast1 = Forecast(temperature: 61, time: "lol", weather: "Sunny")
        forecast2 = Forecast(temperature: 60, time: "lol", weather: "Sunny")
        forecast3 = Forecast(temperature: 59, time: "lol", weather: "Sunny")
        forecast4 = Forecast(temperature: 62, time: "lol", weather: "Sunny")
        
        day = DayViewModel()
        appendForecasts()
        
        super.setUp()
    }
    
    func appendForecasts()
    {
        day?.append(forecast1!)
        day?.append(forecast2!)
        day?.append(forecast3!)
        day?.append(forecast4!)
    }
    
    func testHottest()
    {
        guard let fore = day?.hottest?.forecast else {return}
        guard let fore2 = forecast4 else {return}
        XCTAssertEqual(fore, fore2)
    }
    
    func testColdest()
    {
        guard let fore = day?.hottest?.forecast else {return}
        guard let fore2 = forecast4 else {return}
        XCTAssertEqual(fore, fore2)
    }
    
    func testAppendForecast()
    {
        XCTAssertEqual(day?.forecasts.count, 4)
    }
    
}
