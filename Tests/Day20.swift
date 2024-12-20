import XCTest

@testable import AdventOfCode

// Make a copy of this file for every day to ensure the provided smoke tests
// pass.
final class Day20Tests: XCTestCase {
  // Smoke test data provided in the challenge question
    //let testData = Day20.testData()
  let testData = """
###############
#...#...#.....#
#.#.#.#.#.###.#
#S#...#.#.#...#
#######.#.#.###
#######.#.#...#
#######.#.###.#
###..E#...#...#
###.#######.###
#...###...#...#
#.#####.#.###.#
#.#...#.#.#...#
#.#.#.#.#.#.###
#...#...#...###
###############
"""

  func testPart1() throws {
    let challenge = Day20(data: testData)
    XCTAssertEqual(String(describing: challenge.part1()), "6")
  }

  func testPart2() throws {
    let challenge = Day20(data: testData)
    XCTAssertEqual(String(describing: challenge.part2()), "16")
  }
}
