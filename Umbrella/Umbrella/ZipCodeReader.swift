//
//  ZipCodeReader.swift
//  Umbrella
//
//  Created by User on 9/16/17.
//  Copyright © 2017 DemetrioPerez. All rights reserved.
//

import UIKit

class ZipCodeReader: NSObject
{
    static let instance = ZipCodeReader()
    override private init(){}
    
    //Check if zipCode is acceptable
    func isZipCodeValid( _ zipCode:String)->Bool
    {
        var result = false
        if zipCode.characters.count == 5
        {
            if Int(zipCode) != nil
            {
                DataManager.instance.zipCode = zipCode
                result = true
            }
            
        }
        return result
    }
    

}
