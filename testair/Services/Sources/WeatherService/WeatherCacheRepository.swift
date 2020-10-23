//
//  WeatherCacheRepository.swift
//  
//
//  Created by Maksim Kirko on 10/22/20.
//

import Foundation

//public protocol WeatherRepository {
//    func getCondition(for city: String) throws -> Data
//    func saveCondition(for city: String, data: Data) throws
//    func removeCondition(for city: String, data: Data) throws
//}

public class WeatherCacheRepository {
    private struct Config {
        static let directoryUrl = FileManager.default.urls(for: .cachesDirectory,
                                                           in: .userDomainMask)[0]
        
        static func getCurrentConditionFileUrl(for city: String) -> URL {
            return URL(fileURLWithPath: "\(city.urlEncoded())_condition",
                       relativeTo: Config.directoryUrl).appendingPathExtension("json")
        }
    }
    
    public func getCondition(for city: String) throws -> WeatherConditionModel {
        return try JSONDecoder().decode(WeatherConditionModel.self,
                                        from: Data(contentsOf: Config.getCurrentConditionFileUrl(for: city)))
    }
    
    public func saveCondition(for city: String, condition: WeatherConditionModel) throws {
        try JSONEncoder().encode(condition).write(to: Config.getCurrentConditionFileUrl(for: city))
    }
    
    public func clear() throws {
        let content = try FileManager.default.contentsOfDirectory(
            atPath: Config.directoryUrl.absoluteString
        )
        
        for path in content {
            try FileManager.default.removeItem(atPath: path)
        }
    }
}
