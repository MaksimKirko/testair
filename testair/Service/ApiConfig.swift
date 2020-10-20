//
//  ApiConfig.swift
//  testair
//
//  Created by m.kirko on 10/20/20.
//

import Foundation

class ApiConfig {
    static let shared = ApiConfig()

    let baseUrl = URL(string: "http://api.openweathermap.org")
    let appId = "7587eaff3affbf8e56a81da4d6c51d06"
    
    private init() { }
}

extension URL {
    func appendingAppId() -> URL {
        return URL(string: self.absoluteString.appending("&appId=\(ApiConfig.shared.appId)"))!
    }
}
