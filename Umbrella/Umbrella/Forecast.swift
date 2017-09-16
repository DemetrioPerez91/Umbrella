//
//  Forecast.swift
//  Umbrella
//
//  Created by User on 9/15/17.
//  Copyright © 2017 DemetrioPerez. All rights reserved.
//

import UIKit


class Forecast:NSObject
{
    let temperature:Int
    let time:String
    let weather:String
    
    init(temperature:Int, time:String, weather:String)
    {
        self.temperature = temperature
        self.time = time
        self.weather = weather
    }
}
