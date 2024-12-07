//
//  File.swift
//  AdventOfCode
//
//  Created by Михаил Баринов on 02.12.2024.
//

import XCTest

@testable import AdventOfCode

final class Day02Tests: XCTestCase {
  let testData = Day02.testData()

  func testPart1() throws {
    let challenge = Day02(data: testData)
    XCTAssertEqual(String(describing: challenge.part1()), "442")
  }

  func testPart2() throws {
    let challenge = Day02(data: testData)
    XCTAssertEqual(String(describing: challenge.part2()), "493")
  }
}
