//
//  File.swift
//  AdventOfCode
//
//  Created by Михаил Баринов on 02.12.2024.
//

import XCTest

@testable import AdventOfCode

final class Day03Tests: XCTestCase {
    // Smoke test data provided in the challenge question
    let testData = Day03.testData()

    func testPart1() throws {
        let challenge = Day03(data: testData)
        XCTAssertEqual(String(describing: challenge.part1()), "189527826")
    }                       

    func testPart2() throws {
        let challenge = Day03(data: testData)
        XCTAssertEqual(String(describing: challenge.part2()), "63013756")
    }
}
