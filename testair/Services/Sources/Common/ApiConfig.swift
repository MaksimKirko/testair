//
//  ApiConfig.swift
//  testair
//
//  Created by m.kirko on 10/20/20.
//

import Foundation

public class ApiConfig {
    public static let shared = ApiConfig()

    public let baseUrl = URL(string: "http://api.openweathermap.org")
    public let appId = "7587eaff3affbf8e56a81da4d6c51d06"
    
    private init() { }
}

public extension URL {
    func appendingAppId() -> URL {
        return URL(string: self.absoluteString.appending("&appId=\(ApiConfig.shared.appId)"))!
    }
}
