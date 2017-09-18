//
//  ZipCodeReader.swift
//  Umbrella
//
//  Created by User on 9/16/17.
//  Copyright © 2017 DemetrioPerez. All rights reserved.
//

import Foundation

class ZipCodeReader
{
    class func isZipCodeValid(zipcodeString: String) -> Bool {
        
        if zipcodeString.characters.count == 5,
            let _ = Int(zipcodeString) {

            return true
        }
        return false
    }
}
