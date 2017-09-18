//
//  Extensions.swift
//  Umbrella
//
//  Created by User on 9/16/17.
//  Copyright © 2017 DemetrioPerez. All rights reserved.
//

import Foundation
extension Date
{
    func getCurrentTimeHourMinutes() -> String
    {
        let date = Date()
        let calendar = Calendar.current
        
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        return "\(hour):\(minutes)"
    }
}


extension String {
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
}
