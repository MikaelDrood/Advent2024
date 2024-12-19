import XCTest

@testable import AdventOfCode

// Make a copy of this file for every day to ensure the provided smoke tests
// pass.
final class Day19Tests: XCTestCase {
  // Smoke test data provided in the challenge question
  let testData = """
r, wr, b, g, bwu, rb, gb, br

brwrr
bggr
gbbr
rrbgbr
ubwu
bwurrg
brgr
bbrgwb
"""

  func testPart1() throws {
    let challenge = Day19(data: testData)
    XCTAssertEqual(String(describing: challenge.part1()), "6")
  }

  func testPart2() throws {
    let challenge = Day19(data: testData)
    XCTAssertEqual(String(describing: challenge.part2()), "16")
  }
}
