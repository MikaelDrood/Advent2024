//
//  File.swift
//  AdventOfCode
//
//  Created by Михаил Баринов on 02.12.2024.
//

import Foundation

struct Day03: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String

    func part1() -> Any {
        return getSum(using: /mul\(\d+,\d+\)/)
    }

    func part2() -> Any {
        return getSum(using: /don't\(\)|do\(\)|mul\([0-9]+,[0-9]+\)/)
    }

    private func getSum(using regex: some RegexComponent) -> Int {
        var sum = 0
        var skip = false

        for range in data.ranges(of: regex) {
            let component = data[range]
            switch component {
            case "do()":
                skip = false
            case "don't()":
                skip = true
            default:
                guard !skip else { continue }

                sum += data[range].components(separatedBy: ["(", ")", ","]).reduce(into: 1) { res, str in
                    res *= Int(str) ?? 1
                }
            }
        }

        return sum
    }
}
