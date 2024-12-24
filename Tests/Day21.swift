import XCTest

@testable import AdventOfCode

// Make a copy of this file for every day to ensure the provided smoke tests
// pass.
final class Day21Tests: XCTestCase {
  // Smoke test data provided in the challenge question
  let testData = """
029A
980A
179A
456A
379A
"""
//let testData = """
//179A
//"""

  func testPart1() throws {
    let challenge = Day21(data: testData)
    XCTAssertEqual(String(describing: challenge.part1()), "126384")
  }

  func testPart2() throws {
    let challenge = Day21(data: testData)
    XCTAssertEqual(String(describing: challenge.part2()), "23")
  }
}
