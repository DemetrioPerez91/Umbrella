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
    
    func parseConditions(_ dicitonary:[String:AnyObject])
    {
        var temp:Float = 0.0
        var weather:String = ""
        var time:String = ""
        if let currentobservation = dicitonary["current_observation"] as? [String:AnyObject]
        {
            if let tempf = currentobservation["temp_f"] as? Float
            {
                temp = tempf
            }
            if let weatherS = currentobservation["weather"] as? String
            {
                weather = weatherS
            }
            
            let date = Date()
            time = date.getCurrentTimeHourMinutes()
            
            
        }
        
        let forecast = Forecast(temperature: temp, time: time, weather: weather)
        DataManager.instance.currentConditions = ForecastVM(forecast)
        
    }
    
    
}


