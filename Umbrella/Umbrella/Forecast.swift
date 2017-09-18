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
    let temperature:Float
    let time:String
    let weather:String
    
    init(temperature:Float, time:String, weather:String)
    {
        self.temperature = temperature
        self.time = time
        self.weather = NSLocalizedString(weather, comment: "forecast") 
    }
}
