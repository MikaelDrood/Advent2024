//
//  File.swift
//  AdventOfCode
//
//  Created by Михаил Баринов on 06.12.2024.
//

import XCTest

@testable import AdventOfCode

// Make a copy of this file for every day to ensure the provided smoke tests
// pass.
final class Day06Tests: XCTestCase {
  // Smoke test data provided in the challenge question
  let testData = Day06.testData()

  func testPart1() throws {
    let challenge = Day06(data: testData)
    XCTAssertEqual(String(describing: challenge.part1()), "4454")
  }

  func testPart2() throws {
    let challenge = Day06(data: testData)
    XCTAssertEqual(String(describing: challenge.part2()), "1503")
  }
}
