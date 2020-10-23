//
//  URLResponse+Validation.swift
//  testair
//
//  Created by m.kirko on 10/20/20.
//

import Foundation

public extension URLResponse {
    enum Result<String> {
        case success
        case failure(String)
    }

    func validate() -> Result<String> {
        guard let response = self as? HTTPURLResponse else {
            return .success
        }
        
        switch response.statusCode {
        case 200...299:
            return .success
        case 404:
            return .failure("City not found")
        default:
            return .failure("Request returned with status: \(response.statusCode)")
        }
    }
}

public extension String {
    func urlEncoded() -> String {
        return self.replacingOccurrences(of: " ", with: "%20")
    }
}
