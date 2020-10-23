//
//  Interactor.swift
//  testair
//
//  Created by m.kirko on 10/22/20.
//

import Foundation
import SettingsService
import WeatherService

public protocol Interactor: class {
    func getCurrentCondition(for city: String, completion: @escaping (Result<WeatherConditionModel, Error>) -> Void)
    func getCity() -> String?
}

public class DefaultInteractor: Interactor {
    private let settingsService: SettingsService
    private let weatherService: WeatherService
    
    public init(settingsService: SettingsService, weatherService: WeatherService) {
        self.settingsService = settingsService
        self.weatherService = weatherService
    }
    
    public func getCurrentCondition(for city: String, completion: @escaping (Result<WeatherConditionModel, Error>) -> Void) {
        weatherService.getCurrentCondition(for: city, completion: completion)
    }
    
    public func getCity() -> String? {
        return settingsService.getCity()
    }
}
