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
    var refreshConditionsDelegate:RefreshCurrentConditions?
    var refreshtTableDelegate:RefreshTableProtocol?
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
        refreshtTableDelegate?.refresh()
    }
    
    func setConditions(_ forecast:ForecastVM)
    {
        DataManager.instance.currentConditions = forecast
        self.refreshConditionsDelegate?.refreshConditions()
    }
   
    func setData()
    {
        WebServiceManager.instance.requestData(.Geolocation, completion:
        {
            data in
            JsonParser.instance.parseCityState(data!)
            self.setCurrentCondition()
            self.setForecast()
            
        })
    }
    func setCurrentCondition()
    {
        WebServiceManager.instance.requestData(.Conditions, completion:
            {
                data in
                if let d = data{
                    JsonParser.instance.parseConditions(d)
                }
                else
                {
                    self.setCurrentCondition()
                }
        })
    }
    func setForecast()
    {
        WebServiceManager.instance.requestData(.TenDays, completion:
            {
                data in
                
                if let d = data{
                    JsonParser.instance.parse10Days(d)
                }
                else
                {
                    self.setForecast()
                }
        })
    }
    

}
