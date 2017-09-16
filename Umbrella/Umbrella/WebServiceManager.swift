//
//  WebServiceManager.swift
//  Umbrella
//
//  Created by User on 9/16/17.
//  Copyright © 2017 DemetrioPerez. All rights reserved.
//

import UIKit

class WebServiceManager: NSObject
{
    static let instance = WebServiceManager()
    override private init(){}
    let config = URLSessionConfiguration.default
    
    
    var apiGeolookupURL:String
    {
        get
        {
            return "https://api.wunderground.com/api/4dfa0dce4b7cc546/geolookup/q/\(DataManager.instance.zipCode).json"
        }
    }
    var api10DayForecastURL:String
    {
        get
        {
            return "https://api.wunderground.com/api/4dfa0dce4b7cc546/hourly10day/q/\(DataManager.instance.state)/\(DataManager.instance.city).json"
        }
        
    }
    
    var apiConditionsURL:String
    {
        get
        {
            return "https://api.wunderground.com/api/4dfa0dce4b7cc546/conditions/q/\(DataManager.instance.state)/\(DataManager.instance.city).json"
        }
    }
    
    //get jsons from API
    func requestData(_ requestType:RequestType,completion:@escaping([String:AnyObject]?)->())
    {
        let session = URLSession(configuration: config)
        let request = getRequest(requestType: requestType)
        let task = session.dataTask(with: request, completionHandler: {
            (data,response,error) in
            
            if (error != nil||data == nil)
            {
                print(error!.localizedDescription)
                
            }
            else{
                do{
                    let rootDictionary = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String:AnyObject]
                    completion(rootDictionary)
                    
                }catch {
                    print("Error with Json")
                    completion(nil)
                }
            }
        })
        task.resume()
    }
    //set request depending on type
    func getRequest(requestType:RequestType) ->URLRequest
    {
        var result:URLRequest?
        switch requestType {
        case .Conditions:
            result = URLRequest(url: URL(string: apiConditionsURL)!)
            break
        case .TenDays:
            result = URLRequest(url: URL(string: api10DayForecastURL)!)
            break
        case .Geolocation:
            result = URLRequest(url: URL(string: apiGeolookupURL)!)
        }
        return result!
    }
    
    
    
    
}
