//
//  File.swift
//  
//
//  Created by m.kirko on 10/22/20.
//

import Foundation
import SettingsService
import WeatherService

public protocol Interactor: class {
    var condition: WeatherConditionModel? { get }
    func getCurrentCondition(for city: String,
                             completion: @escaping (Result<WeatherConditionModel, Error>) -> Void)
    func getCity() -> String?
    func saveCity(_ city: String?)
}

public class DefaultInteractor: Interactor {
    private let settingsService: SettingsService
    private let weatherService: WeatherService
    
    public var condition: WeatherConditionModel? {
        return weatherService.fetchedCondition
    }
    
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
    
    public func saveCity(_ city: String?) {
        settingsService.setCity(city)
    }
}
