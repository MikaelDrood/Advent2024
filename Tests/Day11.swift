import XCTest

@testable import AdventOfCode

// Make a copy of this file for every day to ensure the provided smoke tests
// pass.
final class Day11Tests: XCTestCase {
  // Smoke test data provided in the challenge question
  let testData = Day11.testData()
  //let testData = "125 17"

  func testPart1() throws {
    let challenge = Day11(data: testData)
    XCTAssertEqual(String(describing: challenge.part1()), "183620")
  }

  func testPart2() throws {
    let challenge = Day11(data: testData)
    XCTAssertEqual(String(describing: challenge.part2()), "220377651399268")
  }
}
