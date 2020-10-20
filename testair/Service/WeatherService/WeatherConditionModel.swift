//
//  WeatherCondition.swift
//  testair
//
//  Created by m.kirko on 10/20/20.
//

import Foundation

struct WeatherConditionModel: Codable {
    let weather: [Weather]
    let main: Main
    let date: Date
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case weather
        case main
        case date = "dt"
        case name
    }
}

struct Main: Codable {
    let temp: Double
    let tempMin: Double
    let tempMax: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

struct Weather: Codable {
    let description: String
}
