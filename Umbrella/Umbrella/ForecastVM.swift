//
//  ForecastVM.swift
//  Umbrella
//
//  Created by User on 9/15/17.
//  Copyright © 2017 DemetrioPerez. All rights reserved.
//

import UIKit

class ForecastVM: NSObject
{
    
    let forecast:Forecast
    init(_ forecast:Forecast){ self.forecast = forecast}
    
    var temperatureText:String{get{return"\(forecast.temperature)˚"}}
    var timeLocalized:String{get{return"\(forecast.time)"}}
    var weather:WeatherEnum
    {
        get{
            if let w = WeatherEnum(rawValue: forecast.weather)
            {
                return w
            }
            else
            {
                return .Sunny
            }
            
        }
    }
    
    var temperatureInt:Int{get{return forecast.temperature}}
    
    var isHot:Bool
    {
        get
        {
            if forecast.temperature > 60
            {
                return true
            }
            else
            {
                return false
            }
            
        }
    }
    
    var isColdest:Bool = false
    var isHottest:Bool = false
}
