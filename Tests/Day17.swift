import XCTest

@testable import AdventOfCode

// Make a copy of this file for every day to ensure the provided smoke tests
// pass.
final class Day17Tests: XCTestCase {
  // Smoke test data provided in the challenge question
  let testData = """
Register A: 2024
Register B: 0
Register C: 0

Program: 0,3,5,4,3,0
"""

  func testPart1() throws {
    let challenge = Day17(data: testData)
    XCTAssertEqual(String(describing: challenge.part1()), "4,6,3,5,6,3,5,2,1,0")
  }

  func testPart2() throws {
    let challenge = Day17(data: testData)
    XCTAssertEqual(String(describing: challenge.part2()), "117440")
  }
}
