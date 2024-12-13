import XCTest

@testable import AdventOfCode

// Make a copy of this file for every day to ensure the provided smoke tests
// pass.
final class Day13Tests: XCTestCase {
  // Smoke test data provided in the challenge question
  let testData = Day13.testData()
//  let testData = """
//Button A: X+94, Y+34
//Button B: X+22, Y+67
//Prize: X=8400, Y=5400
//
//Button A: X+26, Y+66
//Button B: X+67, Y+21
//Prize: X=12748, Y=12176
//
//Button A: X+17, Y+86
//Button B: X+84, Y+37
//Prize: X=7870, Y=6450
//
//Button A: X+69, Y+23
//Button B: X+27, Y+71
//Prize: X=18641, Y=10279
//"""

  func testPart1() throws {
    let challenge = Day13(data: testData)
    XCTAssertEqual(String(describing: challenge.part1()), "34787")
  }

  func testPart2() throws {
    let challenge = Day13(data: testData)
    XCTAssertEqual(String(describing: challenge.part2()), "885394")
  }
}
