//
//  WeatherClientTests.swift
//  testairTests
//
//  Created by m.kirko on 10/20/20.
//

import XCTest
@testable import testair

class WeatherClientTests: XCTestCase {
    func testUrl() {
        let weatherClient = DefaultWeatherClient()
        let request = weatherClient.getCondition(for: "Vilnius")
        
        XCTAssertEqual(request.url, URL(string: "http://api.openweathermap.org/data/2.5/weather?q=Vilnius&units=metric")!.appendingAppId())
    }
}
