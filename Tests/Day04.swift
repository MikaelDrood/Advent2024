//
//  File.swift
//  AdventOfCode
//
//  Created by Михаил Баринов on 02.12.2024.
//

import XCTest

@testable import AdventOfCode

final class Day04Tests: XCTestCase {
    // Smoke test data provided in the challenge question
    let testData = Day04.testData()

    func testPart1() throws {
        let challenge = Day04(data: testData)
        XCTAssertEqual(String(describing: challenge.part1()), "2685")
    }

    func testPart2() throws {
        let challenge = Day04(data: testData)
        XCTAssertEqual(String(describing: challenge.part2()), "2048")
    }
}
