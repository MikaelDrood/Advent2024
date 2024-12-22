import XCTest

@testable import AdventOfCode

// Make a copy of this file for every day to ensure the provided smoke tests
// pass.
final class Day22Tests: XCTestCase {
  // Smoke test data provided in the challenge question
  let testData = """
1
2
3
2024
"""

  func testPart1() throws {
    let challenge = Day22(data: testData)
    XCTAssertEqual(String(describing: challenge.part1()), "37327623")
  }

  func testPart2() throws {
    let challenge = Day22(data: testData)
    XCTAssertEqual(String(describing: challenge.part2()), "23")
  }
}
