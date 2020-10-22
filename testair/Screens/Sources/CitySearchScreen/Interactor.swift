//
//  Interactor.swift
//  testair
//
//  Created by m.kirko on 10/22/20.
//

import Foundation
import WeatherService

public protocol Interactor: class {
    func getCurrentCondition(for city: String, completion: @escaping (Result<WeatherConditionModel, Error>) -> Void)
}

public class DefaultInteractor: Interactor {
    private let weatherService: WeatherService
    
    public init(weatherService: WeatherService) {
        self.weatherService = weatherService
    }
    
    public func getCurrentCondition(for city: String, completion: @escaping (Result<WeatherConditionModel, Error>) -> Void) {
        weatherService.getCurrentCondition(for: city, completion: completion)
    }
}
