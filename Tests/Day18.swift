import XCTest

@testable import AdventOfCode

// Make a copy of this file for every day to ensure the provided smoke tests
// pass.
final class Day18Tests: XCTestCase {
  // Smoke test data provided in the challenge question
  //let testData = Day18.testData()
  let testData = """
5,4
4,2
4,5
3,0
2,1
6,3
2,4
1,5
0,6
3,3
2,6
5,1
1,2
5,5
2,5
6,5
1,4
0,4
6,4
1,1
6,1
1,0
0,5
1,6
2,0
"""

  func testPart1() throws {
    let challenge = Day18(data: testData)
    XCTAssertEqual(String(describing: challenge.part1()), "22")
  }

  func testPart2() throws {
    let challenge = Day18(data: testData)
    XCTAssertEqual(String(describing: challenge.part2()), "25574739")
  }
}
