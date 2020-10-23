//
//  WeatherService.swift
//  testair
//
//  Created by m.kirko on 10/20/20.
//

import Foundation
import Common

public protocol WeatherService {
    var fetchedCondition: WeatherConditionModel? { get }
    func getCurrentCondition(for city: String, completion: @escaping (Result<WeatherConditionModel, Swift.Error>) -> Void)
    func clearCache()
}

public class DefaultWeatherService: WeatherService {
    private let weatherClient: WeatherClient
    private let weatherCache: WeatherCacheRepository
    private let urlSession: URLSession
    
    public var fetchedCondition: WeatherConditionModel?
    
    public init(weatherClient: WeatherClient) {
        self.weatherClient = weatherClient
        self.weatherCache = WeatherCacheRepository()
        self.urlSession = URLSession.shared
    }
    
    public func getCurrentCondition(for city: String, completion: @escaping (Result<WeatherConditionModel, Swift.Error>) -> Void) {
        if let condition = try? weatherCache.getCondition(for: city) {
            self.fetchedCondition = condition
            completion(.success(condition))
            return
        }
        
        self.urlSession.dataTask(with: weatherClient.getCondition(for: city)) { (data, response, error) in
            if error != nil {
                completion(.failure(DefaultWeatherService.Error.connectionProblems))
                return
            }
            
            guard let response = response else {
                completion(.failure(DefaultWeatherService.Error.emptyResponse))
                return
            }
            
            let result = response.validate()
            switch result {
            case .success:
                guard let responseData = data else {
                    completion(.failure(DefaultWeatherService.Error.emptyData))
                    return
                }
                
                do {
                    let condition = try self.weatherClient.decoder.decode(WeatherConditionModel.self, from: responseData)
                    try? self.weatherCache.saveCondition(for: city, condition: condition)
                    
                    self.fetchedCondition = condition
                    
                    completion(.success(condition))
                } catch {
                    completion(.failure(DefaultWeatherService.Error.decodingError))
                }
            case .failure(let errorDescription):
                completion(.failure(DefaultWeatherService.Error.networkFailure(errorDescription)))
            }
        }.resume()
    }
    
    public func clearCache() {
        try? self.weatherCache.clear()
    }
}

public extension DefaultWeatherService {
    enum Error: Swift.Error {
        case connectionProblems
        case emptyData
        case emptyResponse
        case decodingError
        case networkFailure(String)
    }
}
