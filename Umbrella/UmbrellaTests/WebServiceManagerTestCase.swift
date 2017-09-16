//
//  WebServiceManagerTestCase.swift
//  Umbrella
//
//  Created by User on 9/16/17.
//  Copyright © 2017 DemetrioPerez. All rights reserved.
//

import XCTest
@testable import Umbrella
class WebServiceManagerTestCase: XCTestCase {
    
    override func setUp() {
        super.setUp()
        DataManager.instance.zipCode = "30339"
        DataManager.instance.city = "atlanta"
        DataManager.instance.state = "GA"
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    

    func testLookUpURL()
    {
        
        let WSM = WebServiceManager.instance.apiGeolookupURL
        let url = "https://api.wunderground.com/api/4dfa0dce4b7cc546/geolookup/q/30339.json"
        XCTAssertEqual(WSM, url)
    }
    
    func testStateCityURL()
    {
        let WSM = WebServiceManager.instance.apiConditionsURL
        let url = "https://api.wunderground.com/api/4dfa0dce4b7cc546/conditions/q/GA/atlanta.json"
        XCTAssertEqual(WSM, url)
    }
    
    func testRequestGeolookupData()
    {
        var json:[String:AnyObject]?
        let expectJSON = expectation(description: "Wait for Json")
        WebServiceManager.instance.requestData(RequestType.Geolocation,completion: {
            dic in
            json = dic
            expectJSON.fulfill()
            
        })
        waitForExpectations(timeout: 30, handler:
            {
                _ in
                XCTAssertNotNil(json)
        })
    }
    
    func testRequestForecastLookup()
    {
        var json:[String:AnyObject]?
        let expectJSON = expectation(description: "Wait for Json")
        WebServiceManager.instance.requestData(RequestType.TenDays,completion: {
            dic in
            json = dic
            expectJSON.fulfill()
            
        })
        waitForExpectations(timeout: 30, handler:
            {
                _ in
                XCTAssertNotNil(json)
        })
    }
}
