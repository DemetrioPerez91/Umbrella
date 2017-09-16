//
//  WebServiceManager.swift
//  Umbrella
//
//  Created by User on 9/16/17.
//  Copyright © 2017 DemetrioPerez. All rights reserved.
//

import UIKit

class WebServiceManager: NSObject
{
    static let instance = WebServiceManager()
    override private init(){}
    
    var apiGeolookupURL:String
    {
        get
        {
            return "https://api.wunderground.com/api/4dfa0dce4b7cc546/geolookup/q/\(DataManager.instance.zipCode).json"
        }
    }
    var apiForecastURL:String
    {
        get
        {
            return "http://api.wunderground.com/api/4dfa0dce4b7cc546/forecast/q/\(DataManager.instance.state)/\(DataManager.instance.city).json"
        }
        
    }
    
    
    
    
}
