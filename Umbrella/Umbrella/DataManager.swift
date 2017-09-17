//
//  DataManager.swift
//  Umbrella
//
//  Created by User on 9/16/17.
//  Copyright © 2017 DemetrioPerez. All rights reserved.
//

import UIKit

class DataManager: NSObject
{
    static let instance = DataManager()
    override private init(){}
    
    private(set) var days:[DayViewModel]=[]
    var currentConditions:ForecastVM?
    var refreshDelegate:RefreshTableProtocol?
    var zipCode:String = ""
    var state:String = ""
    var city:String = ""
    var location:String
    {
        get
        {
            return "\(city),\(state)"
        }
    }
    
    func setDays(days:[DayViewModel])
    {
        self.days = days
        refreshDelegate?.refresh()
    }
    

}
