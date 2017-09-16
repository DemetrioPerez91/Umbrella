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
    
    func parse10Days(_ dictionary:[String:AnyObject])
    {
        //Prepare day array
        var days:[DayViewModel] = []
        var dayCurrentHour = 0
        //Get RESULTS FROM DICTIONARY
        if let hourly = dictionary["hourly_forecast"] as? [AnyObject]
        {
            var newDay = DayViewModel()
            for forecast in hourly
            {
                var time = ""
                var temp:Float = 0.0
                var condition = ""
                
                if let ftime = forecast["FCTTIME"] as? [String:AnyObject]
                {
                    guard let dch = Int((ftime["hour"] as? String!)!)else
                    {
                        print("Failure")
                        return
                    }
                    dayCurrentHour = dch
                    if let t = ftime["civil"] as? String
                    {
                        time = t
                    }
                }
                if let cond = forecast["condition"] as? String
                {
                    condition = cond
                }
                
                if let temperature = forecast["temp"] as? [String:AnyObject]
                {
                    guard let degrees = Float((temperature["english"] as? String!)!)else
                    {
                        print("Failure")
                        return
                    }
                    temp = degrees

                }
                let forecast = Forecast(temperature: temp, time: time, weather: condition)
                newDay.append(forecast)
                if dayCurrentHour == 23
                {
                    days.append(newDay)
                    newDay = DayViewModel()
                }
                
            }
        }
        DataManager.instance.setDays(days: days)
        
    }
    
    
}


