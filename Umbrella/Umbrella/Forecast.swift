//
//  Forecast.swift
//  Umbrella
//
//  Created by User on 9/15/17.
//  Copyright © 2017 DemetrioPerez. All rights reserved.
//

import Foundation

struct Forecast
{
    let temperature:Float
    let time:String
    let weather:String
    
    init(temperature:Float, time:String, weather:String)
    {
        self.temperature = temperature
        self.time = time
        self.weather = weather
    }
}
