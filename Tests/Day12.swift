import XCTest

@testable import AdventOfCode

// Make a copy of this file for every day to ensure the provided smoke tests
// pass.
final class Day12Tests: XCTestCase {
  // Smoke test data provided in the challenge question
  let testData = Day12.testData()

  func testPart1() throws {
    let challenge = Day12(data: testData)
    XCTAssertEqual(String(describing: challenge.part1()), "1421958")
  }

  func testPart2() throws {
    let challenge = Day12(data: testData)
    XCTAssertEqual(String(describing: challenge.part2()), "885394")
  }
}
