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
            JsonParser.instance.parseCityState(dictionary!)
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
    
    
    
    
    
}
