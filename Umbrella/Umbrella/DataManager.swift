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
    
    var days:[DayViewModel]=[]
    

}
