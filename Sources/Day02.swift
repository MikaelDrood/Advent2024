//
//  File.swift
//  AdventOfCode
//
//  Created by Михаил Баринов on 02.12.2024.
//

import Foundation

struct Day02: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String

    var entities: [[Int]] {
        let reports = data.components(separatedBy: "\n")
        return reports.map { $0.components(separatedBy: " ").compactMap { Int($0) }}
    }

    func part1() -> Any {
        return entities.reduce(into: 0) { res, ar in
            res += (unsafeIndex(ar, -1) == -1) ? 1 : 0
        }
    }

    func part2() -> Any {
        return entities.reduce(into: 0) { res, ar in
            let unsafeI = unsafeIndex(ar, -1)

            if unsafeI == -1 {
                res += 1
            } else if unsafeIndex(ar, unsafeI) == -1 ||
                      unsafeIndex(ar, unsafeI - 1) == -1 ||
                      unsafeIndex(ar, unsafeI - 2) == -1 {
                res += 1
            }
        }
    }

    private func unsafeIndex(_ ar: [Int], _ unsafeI: Int) -> Int {
        var ar = ar

        if unsafeI >= 0 {
            ar.remove(at: unsafeI)
        }

        let isAsc = ar[1] > ar[0]

        for i in 1 ..< ar.count {
            let dif = abs(ar[i] - ar[i - 1])

            guard dif > 0, dif < 4,
                  isAsc == (ar[i] > ar[i - 1]) else {
                return i
            }
        }

        return -1
    }
}
