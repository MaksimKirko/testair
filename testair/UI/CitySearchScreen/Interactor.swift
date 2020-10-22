//
//  Interactor.swift
//  testair
//
//  Created by m.kirko on 10/22/20.
//

import Foundation

protocol Interactor: class {
    func getCurrentCondition(for city: String, completion: @escaping (Result<WeatherConditionModel, Error>) -> Void)
}

class DefaultInteractor: Interactor {
    private let weatherService: WeatherService
    
    init(weatherService: WeatherService) {
        self.weatherService = weatherService
    }
    
    func getCurrentCondition(for city: String, completion: @escaping (Result<WeatherConditionModel, Error>) -> Void) {
        weatherService.getCurrentCondition(for: city, completion: completion)
    }
}
