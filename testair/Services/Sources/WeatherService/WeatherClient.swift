//
//  WeatherClient.swift
//  testair
//
//  Created by m.kirko on 10/20/20.
//

import Foundation
import Common

public protocol WeatherClient {
    var decoder: JSONDecoder { get }
    
    func getCondition(for city: String) -> URLRequest
}

public class DefaultWeatherClient: WeatherClient {
    private struct Config {
        static let conditionUrl = URL(string: "data/2.5/weather", relativeTo: ApiConfig.shared.baseUrl)
        
        static func getConditionEndpoint(for city: String) -> URL {
            return URL(string: "?q=\(city)&units=metric", relativeTo: conditionUrl)!.appendingAppId()
        }
    }
    
    public init() { }
    
    public var decoder: JSONDecoder {
        let jsonDecoder = JSONDecoder()

        jsonDecoder.dateDecodingStrategy = .custom({ (decoder) -> Date in
            guard let timestamp = try? Double(from: decoder) else {
                throw DefaultWeatherClient.Error.invalidDateFormat
            }
            
            return Date(timeIntervalSince1970: timestamp)
        })
        return jsonDecoder
    }
    
    public func getCondition(for city: String) -> URLRequest {
        return URLRequest(url: Config.getConditionEndpoint(for: city))
    }
}

extension DefaultWeatherClient {
    public enum Error: Swift.Error {
        case invalidDateFormat
    }
}
