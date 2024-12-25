import XCTest

@testable import AdventOfCode

// Make a copy of this file for every day to ensure the provided smoke tests
// pass.
final class Day25Tests: XCTestCase {
  // Smoke test data provided in the challenge question
  let testData = """
#####
.####
.####
.####
.#.#.
.#...
.....

#####
##.##
.#.##
...##
...#.
...#.
.....

.....
#....
#....
#...#
#.#.#
#.###
#####

.....
.....
#.#..
###..
###.#
###.#
#####

.....
.....
.....
#....
#.#..
#.#.#
#####
"""

  func testPart1() throws {
    let challenge = Day25(data: testData)
    XCTAssertEqual(String(describing: challenge.part1()), "3")
  }

  func testPart2() throws {
    let challenge = Day25(data: testData)
    XCTAssertEqual(String(describing: challenge.part2()), "23")
  }
}
