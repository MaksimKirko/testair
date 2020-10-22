//
//  File.swift
//  
//
//  Created by m.kirko on 10/22/20.
//

import Foundation
import WeatherService

public protocol Interactor: class {
    var condition: WeatherConditionModel? { get }
}

public class DefaultInteractor: Interactor {
    private let weatherService: WeatherService

    public var condition: WeatherConditionModel? {
        return weatherService.fetchedCondition
    }
    
    public init(weatherService: WeatherService) {
        self.weatherService = weatherService
    }
}
