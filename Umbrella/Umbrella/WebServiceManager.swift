//
//  WebServiceManager.swift
//  Umbrella
//
//  Created by User on 9/16/17.
//  Copyright © 2017 DemetrioPerez. All rights reserved.
//

import Foundation

fileprivate struct webAPI {
    
    static var apiGeolookupURL: String {
        return "https://api.wunderground.com/api/4dfa0dce4b7cc546/geolookup/q/\(DataManager.instance.zipCode).json"
    }

    static var api10DayForecastURL: String {
        let url = "https://api.wunderground.com/api/4dfa0dce4b7cc546/hourly10day/q/\(DataManager.instance.state)/\(DataManager.instance.city).json"
        let trimmedString = url.replacingOccurrences(of: " ", with: "_")
        return trimmedString
    }
    
    static var apiConditionsURL: String {
        let url = "https://api.wunderground.com/api/4dfa0dce4b7cc546/conditions/q/\(DataManager.instance.state)/\(DataManager.instance.city).json"
        let trimmedString = url.replacingOccurrences(of: " ", with: "_")
        
        return trimmedString
    }
}

class WebServiceManager
{
    static let instance = WebServiceManager()
    private init(){}
    
    let config = URLSessionConfiguration.default

    func requestData(_ requestType:RequestType, completion:@escaping([String:AnyObject]?)->())
    {
        let session = URLSession(configuration: config)
        guard let request = getRequest(requestType: requestType) else {
            completion(nil)
            return
        }
        
        session.dataTask(with: request) { (data,response,error) in
            
            if (error != nil||data == nil)
            {
                print(error!.localizedDescription)
                return
            }
            
            guard let weatherData = data else {
                completion(nil)
                return
            }
            
            do{
                let rootDictionary = try JSONSerialization
                    .jsonObject(with: weatherData,
                                options: .allowFragments) as? [String:AnyObject]
                completion(rootDictionary)
                
            }catch {
                print("Error with Json")
                completion(nil)
            }
        }.resume()
    }
    
    //set request depending on type
    private func getRequest(requestType: RequestType) -> URLRequest?
    {
        
        switch requestType {
        case .Conditions:
            
            guard let url = URL(string: webAPI.apiConditionsURL) else { return nil }
            return URLRequest(url: url)

        case .TenDays:
            
            guard let url = URL(string: webAPI.api10DayForecastURL) else { return nil }
            return URLRequest(url: url)

        case .Geolocation:
            
            guard let url = URL(string: webAPI.apiGeolookupURL) else { return nil }
            return URLRequest(url: url)
        }
    }
}
