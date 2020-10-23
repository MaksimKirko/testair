//
//  WeatherCondition.swift
//  testair
//
//  Created by m.kirko on 10/20/20.
//

import Foundation

public struct WeatherConditionModel: Codable {
    public let weather: [Weather]
    public let main: Main
    public let date: Date
    public let city: String
    
    enum CodingKeys: String, CodingKey {
        case weather
        case main
        case date = "dt"
        case city = "name"
    }
}

public struct Main: Codable {
    public let temp: Double
    public let tempMin: Double
    public let tempMax: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

public struct Weather: Codable {
    public let description: String
}
