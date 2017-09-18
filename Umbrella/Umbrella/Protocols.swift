//
//  RefreshTableProtocol.swift
//  Umbrella
//
//  Created by User on 9/16/17.
//  Copyright © 2017 DemetrioPerez. All rights reserved.
//

import Foundation

protocol RefreshTableProtocol: class {
    func refresh()
}
protocol RefreshCurrentConditions: class {
    func refreshConditions()
}

protocol ZipCodeRequestResponder: class {
    func success()
    func failure()
}
