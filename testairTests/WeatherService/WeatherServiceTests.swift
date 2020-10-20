//
//  WeatherServiceTests.swift
//  testairTests
//
//  Created by m.kirko on 10/20/20.
//

import XCTest
@testable import testair

class WeatherServiceTests: XCTestCase {
    class MockWeatherClient: WeatherClient {
        var decoder: JSONDecoder {
            let jsonDecoder = JSONDecoder()

            jsonDecoder.dateDecodingStrategy = .custom({ (decoder) -> Date in
                guard let timestamp = try? Double(from: decoder) else {
                    throw DefaultWeatherClient.Error.invalidDateFormat
                }
                
                return Date(timeIntervalSince1970: timestamp)
            })
            return jsonDecoder
        }
        
        var filename = "current_condition_response"
        
        func getCondition(for city: String) -> URLRequest {
            return URLRequest(url: Bundle(for: MockWeatherClient.self).url(forResource: filename, withExtension: "json")!)
        }
    }

    var weatherClient: MockWeatherClient!
    var weatherService: WeatherService!
    
    override func setUp() {
        weatherClient = MockWeatherClient()
        weatherService = DefaultWeatherService(weatherClient: weatherClient!)
    }
    
    func testGetCurrentCondition() {
        let fetchExpectation = expectation(description: "Fetching current condition")
        var requestResult: Result<WeatherConditionModel, Error>?
        
        weatherService.getCurrentCondition(for: "Vilnius") { result in
            requestResult = result
            fetchExpectation.fulfill()
        }
        
        wait(for: [fetchExpectation], timeout: 1)
        
        guard let result = requestResult else {
            XCTFail("Result cannot be nil")
            return
        }
        
        switch result {
        case .success(let condition):
            XCTAssertEqual(condition.weather[0].description, "scattered clouds")
            XCTAssertEqual(condition.date, Date(timeIntervalSince1970: 1603181480))
        case .failure(let error):
            XCTFail(error.localizedDescription)
        }
    }
    
    func testGetCurrentConditionWithError() {
        weatherClient.filename = "current_condition_error"
        
        let fetchExpectation = expectation(description: "Fetching current condition")
        var requestResult: Result<WeatherConditionModel, Error>?
        
        weatherService.getCurrentCondition(for: "asdfg") { result in
            requestResult = result
            fetchExpectation.fulfill()
        }
        
        wait(for: [fetchExpectation], timeout: 1)
        
        guard let result = requestResult else {
            XCTFail("Result cannot be nil")
            return
        }
        
        switch result {
        case .success(_):
            XCTFail("Should be an error")
        case .failure(let error):
            guard error is DefaultWeatherService.Error else {
                XCTFail("Wrong error type - should be \(DefaultWeatherService.Error.networkFailure("").self)")
                return
            }
        }
    }
}
