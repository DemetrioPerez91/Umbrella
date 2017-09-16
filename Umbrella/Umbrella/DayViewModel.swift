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
        if forecasts.count == 0
        {
            forecasts.append(ForecastVM(forecast))
        }
        
    }
}
