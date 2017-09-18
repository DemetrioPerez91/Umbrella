//
//  JsonParsrTestCase.swift
//  Umbrella
//
//  Created by User on 9/16/17.
//  Copyright © 2017 DemetrioPerez. All rights reserved.
//

import XCTest
@testable import Umbrella
class JsonParsrTestCase: XCTestCase {
    
    
    override func setUp() {
        super.setUp()
       
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testParseCityAndState()
    {
        
        let parseCity = "Atlanta"
        let  parseState = "GA"
        DataManager.instance.zipCode = "30339"
        let expectParse = expectation(description: "Parse State")
        WebServiceManager.instance.requestData(.Geolocation, completion:
        {
                dictionary in
            JsonParser.instance.parseCityState(dictionary!,completion:{_ in})
            expectParse.fulfill()
        })
        waitForExpectations(timeout: 20, handler: {
            _ in
            let dmState = DataManager.instance.state
            let dmCity = DataManager.instance.city
            XCTAssertEqual(dmState, parseState)
            XCTAssertEqual(dmCity, parseCity)
            
        })
    }
    
    func testParseConditions()
    {
        DataManager.instance.city = "Atlanta"
        DataManager.instance.state = "GA"
        let expectParse = expectation(description: "Parse json")
        WebServiceManager.instance.requestData(.Conditions, completion:
            {
                dictionary in
                JsonParser.instance.parseConditions(dictionary!)
                expectParse.fulfill()
        })
        waitForExpectations(timeout: 20, handler: {
            _ in
            let time = DataManager.instance.currentConditions?.time
            let temp = DataManager.instance.currentConditions?.temperatureFloat
            let weather = DataManager.instance.currentConditions?.weather.rawValue
            XCTAssertNotEqual(time, "")
            XCTAssertNotEqual(temp, 0.0)
            XCTAssertNotEqual(weather, "")
            
            
        })
    }
    
    func testParse10DayRequest()
    {
        DataManager.instance.city = "Atlanta"
        DataManager.instance.state = "GA"
        let expectParse = expectation(description: "Parse State")
        WebServiceManager.instance.requestData(.TenDays, completion:
            {
                dictionary in
                JsonParser.instance.parse10Days(dictionary!)
                //Create adecuate parsing function
                expectParse.fulfill()
        })
        waitForExpectations(timeout: 20, handler: {
            _ in
            XCTAssertEqual(DataManager.instance.days.count, 10)
            
        })
    }
    
    
}
