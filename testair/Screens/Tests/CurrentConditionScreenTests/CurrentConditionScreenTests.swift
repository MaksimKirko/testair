import XCTest
@testable import CurrentConditionScreen

final class CurrentConditionScreenTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Screens().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
