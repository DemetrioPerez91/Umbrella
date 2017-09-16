//
//  JsonParser.swift
//  Umbrella
//
//  Created by User on 9/16/17.
//  Copyright © 2017 DemetrioPerez. All rights reserved.
//

import UIKit

class JsonParser: NSObject
{
    static let  instance = JsonParser()
    override init(){}
    func parseCityState(_ dictionary:[String:AnyObject])
    {
        //var planets:[PlanetViewModel] = []
        let array = dictionary["results"] as? [AnyObject]
        
        for i in array!
        {
            let name = i["name"]!
            print(name!)
            let climate = i["climate"]!
            print(climate!)
           // let url = DataManager.manager.planetURL
            //let newPLanet = Planet(name: name as! String, climate: climate as! String, url: url)
            //planets.append(PlanetViewModel(planet: newPLanet))
            
        }
        
        //return planets
    }
    
}
