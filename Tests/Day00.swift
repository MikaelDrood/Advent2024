import XCTest

@testable import AdventOfCode

// Make a copy of this file for every day to ensure the provided smoke tests
// pass.
final class Day00Tests: XCTestCase {
  // Smoke test data provided in the challenge question
    let testData = Day00.testData()

  func testPart1() throws {
    let challenge = Day00(data: testData)
    XCTAssertEqual(String(describing: challenge.part1()), "6000")
  }

  func testPart2() throws {
    let challenge = Day00(data: testData)
    XCTAssertEqual(String(describing: challenge.part2()), "32000")
  }
}
