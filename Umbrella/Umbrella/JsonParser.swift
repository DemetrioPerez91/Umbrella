//
//  JsonParser.swift
//  Umbrella
//
//  Created by User on 9/16/17.
//  Copyright © 2017 DemetrioPerez. All rights reserved.
//

import UIKit

class JsonParser: NSObject
{
    static let  instance = JsonParser()
    override init(){}
    func parseCityState(_ dictionary:[String:AnyObject])
    {
        if let location = dictionary["location"] as? [String:AnyObject]
        {
            if let city = location["city"] as? String

            {
                DataManager.instance.city = city
            }
            if let state = location["state"] as? String

            {
                DataManager.instance.state = state
            }
        }
    }
}
