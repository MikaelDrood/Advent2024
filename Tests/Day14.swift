import XCTest

@testable import AdventOfCode

// Make a copy of this file for every day to ensure the provided smoke tests
// pass.
final class Day14Tests: XCTestCase {
  // Smoke test data provided in the challenge question
  let testData = Day14.testData()
//  let testData = """
//p=0,4 v=3,-3
//p=6,3 v=-1,-3
//p=10,3 v=-1,2
//p=2,0 v=2,-1
//p=0,0 v=1,3
//p=3,0 v=-2,-2
//p=7,6 v=-1,-3
//p=3,0 v=-1,-2
//p=9,3 v=2,3
//p=7,3 v=-1,2
//p=2,4 v=2,-3
//p=9,5 v=-3,-3
//"""

  func testPart1() throws {
    let challenge = Day14(data: testData)
    XCTAssertEqual(String(describing: challenge.part1()), "224438715")
  }

  func testPart2() throws {
    let challenge = Day14(data: testData)
    XCTAssertEqual(String(describing: challenge.part2()), "7603")
  }
}
