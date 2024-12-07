//
//  File.swift
//  AdventOfCode
//
//  Created by Михаил Баринов on 02.12.2024.
//

import Foundation

struct Day04: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String

    var m: [[Character]] {
        return data.components(separatedBy: "\n").map { row in
            var r: [Character] = []
            for ch in row {
                r.append(ch)
            }
            return r
        }
    }

    func part1() -> Any {
        let rCount = m.count
        let cCount = m[0].count

        let d: [Int: Character] = "XMAS".enumerated().reduce(into: [:]) { res, p in res[p.0] = p.1 }
        var count = 0

        func check(_ r: Int, _ c: Int, _ chI: Int, _ mut: [Int]) -> Bool {
            var chI = chI
            var r = r, c = c

            while let ch = d[chI], r >= 0, r < rCount, c >= 0, c < cCount, m[r][c] == ch {
                chI += 1
                r += mut[0]
                c += mut[1]
            }

            return d[chI] == nil
        }

        for r in 0 ..< rCount {
            for c in 0 ..< cCount {
                [[0, -1], [-1, -1], [-1, 0], [-1, 1], [0, 1], [1, 1], [1, 0], [1, -1]].forEach {
                    count += check(r, c, 0, $0) ? 1 : 0
                }
            }
        }

        return count
    }

    func part2() -> Any {
        let rCount = m.count
        let cCount = m[0].count

        var count = 0

        func xCheck(_ r: Int, _ c: Int) -> Bool {
            guard m[r][c] == "A" else { return false }
            guard r >= 1, r < rCount - 1, c >= 1, c < cCount - 1 else { return false }

            var perimeter:[Character] = []
            var mCount = 0, sCount = 0

            for mut in [[-1, -1], [-1, 1], [1, 1], [1, -1]] {
                let r = r + mut[0], c = c + mut[1]
                let ch = m[r][c]

                guard ch == "M" || ch == "S" else { return false }

                mCount += ch == "M" ? 1 : 0
                sCount += ch == "S" ? 1 : 0

                perimeter.append(m[r][c])
            }

            return perimeter[0...1] != perimeter[2...3] && mCount == sCount
        }

        for r in 0 ..< rCount {
            for c in 0 ..< cCount {
                count += xCheck(r, c) ? 1 : 0
            }
        }

        return count
    }
}
