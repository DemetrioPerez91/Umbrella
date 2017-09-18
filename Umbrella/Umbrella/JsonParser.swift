//
//  JsonParser.swift
//  Umbrella
//
//  Created by User on 9/16/17.
//  Copyright © 2017 DemetrioPerez. All rights reserved.
//

import Foundation

class JsonParser
{
    static let instance = JsonParser()
    
    func parseCityState(dictionary: [String:AnyObject], completion:(Bool)->())
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
            completion(true)
        }
        else
        {
            completion(false)
        }
    }
    
    func parseConditions(dictionary: [String:AnyObject])
    {
        var temp: Float = 0.0
        var weather: String = ""
        var time: String = ""
        if let currentobservation = dictionary["current_observation"] as? [String:AnyObject]
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
        DataManager.instance.setConditions(ForecastVM(forecast))
        
        
    }
    
    func parse10Days(dictionary: [String:AnyObject])
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
                    guard let englishString = temperature["english"] as? String,
                        let degrees = Float(englishString) else {
                            print("failure")
                            return
                    }
                    temp = degrees

                }
                let forecast = Forecast(temperature: temp, time: time, weather: condition)
                newDay.append(forecast)
                if dayCurrentHour == 23
                {
                    newDay.hottest?.isHottest = true
                    newDay.coldest?.isColdest = true
                    var i = 0
                    print("Day \(days.count + 1)||||||||||||||||||||||||||||||")
                    for fore in newDay.forecasts
                    {
                        i = i + 1
                        print("Forecast \(i)")
                        print("HOUR: \(fore.time)")
                        print("is Hottest: \(fore.isHottest)")
                        print("is coldest: \(fore.isColdest)")
                    }
                    days.append(newDay)
                    newDay = DayViewModel()
                }
                
            }
            
        }
        DataManager.instance.setDays(days: days)
        
    }
    
    
}


