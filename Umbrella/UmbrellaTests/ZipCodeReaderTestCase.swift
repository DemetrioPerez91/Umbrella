//
//  ZipCodeReaderTestCase.swift
//  Umbrella
//
//  Created by User on 9/16/17.
//  Copyright © 2017 DemetrioPerez. All rights reserved.
//

import XCTest
@testable import Umbrella

class ZipCodeReaderTestCase: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testInvalid()
    {
        let invalidZipCode1 = "AAAaa"
        let invalidZipCode2 = "1A11A"
        let invalidZipCode3 = "1A1 A"
        let invalidZipCode4 = "1A1.A"
        let invalidZipCode5 = "111.1"
        let invalidZipCode6 = "111111"
        XCTAssertFalse(ZipCodeReader.instance.isZipCodeValid(invalidZipCode1))
        XCTAssertFalse(ZipCodeReader.instance.isZipCodeValid(invalidZipCode2))
        XCTAssertFalse(ZipCodeReader.instance.isZipCodeValid(invalidZipCode3))
        XCTAssertFalse(ZipCodeReader.instance.isZipCodeValid(invalidZipCode4))
        XCTAssertFalse(ZipCodeReader.instance.isZipCodeValid(invalidZipCode5))
        XCTAssertFalse(ZipCodeReader.instance.isZipCodeValid(invalidZipCode6))
        
    }
   
    func testValid()
    {
        let zip = "11111"
        XCTAssert(ZipCodeReader.instance.isZipCodeValid(zip))
    }
}
