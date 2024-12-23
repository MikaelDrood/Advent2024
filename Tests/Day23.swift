import XCTest

@testable import AdventOfCode

// Make a copy of this file for every day to ensure the provided smoke tests
// pass.
final class Day23Tests: XCTestCase {
  // Smoke test data provided in the challenge question
  let testData = """
kh-tc
qp-kh
de-cg
ka-co
yn-aq
qp-ub
cg-tb
vc-aq
tb-ka
wh-tc
yn-cg
kh-ub
ta-co
de-co
tc-td
tb-wq
wh-td
ta-ka
td-qp
aq-cg
wq-ub
ub-vc
de-ta
wq-aq
wq-vc
wh-yn
ka-de
kh-ta
co-tc
wh-qp
tb-vc
td-yn
"""

  func testPart1() throws {
    let challenge = Day23(data: testData)
    XCTAssertEqual(String(describing: challenge.part1()), "7")
  }

  func testPart2() throws {
    let challenge = Day23(data: testData)
    XCTAssertEqual(String(describing: challenge.part2()), "co,de,ka,ta")
  }
}
