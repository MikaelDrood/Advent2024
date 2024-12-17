import XCTest

@testable import AdventOfCode

// Make a copy of this file for every day to ensure the provided smoke tests
// pass.
final class Day16Tests: XCTestCase {
  // Smoke test data provided in the challenge question
  //let testData = Day16.testData()
  let testData = """
###############
#.......#....E#
#.#.###.#.###.#
#.....#.#...#.#
#.###.#####.#.#
#.#.#.......#.#
#.#.#####.###.#
#...........#.#
###.#.#####.#.#
#...#.....#.#.#
#.#.#.###.#.#.#
#.....#...#.#.#
#.###.#.#.#.#.#
#S..#.....#...#
###############
"""

  func testPart1() throws {
    let challenge = Day16(data: testData)
    XCTAssertEqual(String(describing: challenge.part1()), "7036")
  }

  func testPart2() throws {
    let challenge = Day16(data: testData)
    XCTAssertEqual(String(describing: challenge.part2()), "25574739")
  }
}
