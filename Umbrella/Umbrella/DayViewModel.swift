//
//  DayViewModel.swift
//  Umbrella
//
//  Created by User on 9/15/17.
//  Copyright © 2017 DemetrioPerez. All rights reserved.
//

import UIKit

class DayViewModel: NSObject
{
    var forecasts:[ForecastVM] = []
    var hottest:ForecastVM?
    var coldest:ForecastVM?
    
    func append(_ forecast:Forecast)
    {
        let VM = ForecastVM(forecast)
        if forecasts.count == 0
        {
            forecasts.append(VM)
            hottest = VM
            coldest = VM   
        }
        else
        {
            if VM.temperatureFloat > (hottest?.temperatureFloat)!
            {
                hottest = VM
            }
            
            if VM.temperatureFloat < (coldest?.temperatureFloat)!
            {
                coldest = VM
            }
            forecasts.append(VM)
        }
        
    }
}
