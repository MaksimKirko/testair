//
//  WeatherCacheRepository.swift
//  
//
//  Created by Maksim Kirko on 10/22/20.
//

import Foundation

public protocol WeatherRepository {
    func getCondition(for city: String) throws -> WeatherConditionModel
    func saveCondition(for city: String, condition: WeatherConditionModel) throws
    func clear() throws
}

public class WeatherCacheRepository: WeatherRepository {
    private struct Config {
        static let directoryUrl = try? FileManager.default.url(for: .cachesDirectory,
                                                               in: .userDomainMask,
                                                               appropriateFor: nil,
                                                               create: true)
        
        static let currentConditionDirectoryUrl = directoryUrl?.appendingPathComponent("current_condition", isDirectory: true)
        
        static func getCurrentConditionFileUrl(for city: String) -> URL {
            return URL(fileURLWithPath: "\(city.urlEncoded())_condition",
                       relativeTo: Config.currentConditionDirectoryUrl).appendingPathExtension("json")
        }
    }
    
    public init() {
        guard let currentConditionDirectoryUrl = Config.currentConditionDirectoryUrl else {
            print("Invalid directory url")
            return
        }
        
        do {
            try FileManager.default.createDirectory(at: currentConditionDirectoryUrl,
                                                withIntermediateDirectories: true,
                                                attributes: nil)
        } catch {
            print("Error during creating directory: \(currentConditionDirectoryUrl)")
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
        if let currentConditionDirectoryUrl = Config.currentConditionDirectoryUrl {
            try FileManager.default.removeItem(at: currentConditionDirectoryUrl)
        }
    }
}
