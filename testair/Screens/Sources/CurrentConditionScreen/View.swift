//
//  File.swift
//  
//
//  Created by m.kirko on 10/22/20.
//

import Foundation
import WeatherService

public protocol View: class {
    func showCondition(condition: WeatherConditionModel)
    func showError(error: Error)
}
