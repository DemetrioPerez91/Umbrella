//
//  DataManager.swift
//  Umbrella
//
//  Created by User on 9/16/17.
//  Copyright © 2017 DemetrioPerez. All rights reserved.
//

import Foundation

class DataManager
{
    static let instance = DataManager()
    private init(){}
    
    private(set) var days: [DayViewModel]=[]
    var currentConditions: ForecastVM?
    weak var refreshConditionsDelegate: RefreshCurrentConditions?
    weak var refreshtTableDelegate: RefreshTableProtocol?
    var zipCodeRequestResponder: ZipCodeRequestResponder?
    var zipCode:String = ""
    var state:String = ""
    var city:String = ""
    
    var location:String {
        return "\(city),\(state)"
    }
    
    func setDays(days:[DayViewModel]) {
        
        self.days = days
        refreshtTableDelegate?.refresh()
    }
    
    func setConditions(_ forecast:ForecastVM){
        
        DataManager.instance.currentConditions = forecast
        self.refreshConditionsDelegate?.refreshConditions()
    }
   
    
    func setCurrentCondition() {
        WebServiceManager.instance.requestData(.Conditions){ data in
            if let weatherData = data{
                JsonParser.instance.parseConditions(dictionary: weatherData)
            }
            else
            {
                self.setCurrentCondition()
            }
        }
    }
    
    func setForecast() {
        WebServiceManager.instance.requestData(.TenDays) { [weak self] data in
            if let weatherData = data{
                JsonParser.instance.parse10Days(dictionary: weatherData)
            }
            else
            {
                self?.setForecast()
            }
        }
    }
    
    func setData() {
        WebServiceManager.instance.requestData(.Geolocation) { [weak self] data in
            
            guard let jsonData = data else {
                self?.zipCodeRequestResponder?.failure()
                return
            }
            
            JsonParser.instance.parseCityState(dictionary: jsonData){ isValid in
                if isValid {
                    self?.setCurrentCondition()
                    self?.setForecast()
                    self?.zipCodeRequestResponder?.success()
                }
                else{
                    self?.zipCodeRequestResponder?.failure()
                }
            }
        }
    }

}
