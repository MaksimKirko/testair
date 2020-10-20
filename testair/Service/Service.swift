//
//  Service.swift
//  testair
//
//  Created by m.kirko on 10/20/20.
//

import Foundation

class RequestProcessor<T: Codable> {
    var decoder: JSONDecoder
    
    init(decoder: JSONDecoder) {
        self.decoder = decoder
    }
    
    func processRequest(data: Data?, response: URLResponse?, error: Error?) -> Result<T, Error> {
        guard error != nil else {
            return .failure(.connectionProblems)
        }
        
        guard let response = response else {
            return .failure(.emptyResponse)
        }
        
        switch response.validate() {
        case .success:
            guard let responseData = data else {
                return .failure(.emptyData)
            }
            
            do {
                let decodedResult = try self.decoder.decode(T.self, from: responseData)
                return .success(decodedResult)
            } catch {
                return .failure(.decodingError)
            }
        case .failure(let errorDescription):
            return .failure(.networkFailure(errorDescription))
        }
    }
    
    public enum Error: Swift.Error {
        case connectionProblems
        case emptyData
        case emptyResponse
        case decodingError
        case networkFailure(String)
    }
}
