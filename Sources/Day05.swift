//
//  File.swift
//  AdventOfCode
//
//  Created by Михаил Баринов on 02.12.2024.
//

import Foundation

struct Day05: AdventDay {
    
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String

    private var rules: [Int: [Int]] = [:]
    private var input: [[Int]] = []

    init(data: String) {
        self.data = data

        for c in data.components(separatedBy: "\n").filter({ !$0.isEmpty }) {
            if c.firstIndex(of: "|") != nil {
                let r = c.components(separatedBy: "|").map { Int($0)! }
                rules[r[0], default: []].append(r[1])
            } else {
                let i = c.components(separatedBy: ",").map { Int($0)! }
                input.append(i)
            }
        }
    }

    func part1() -> Any {
        var ans = 0
        
        for pages in input {
            let order = pages.enumerated().reduce(into: [:]) { res, p in
                res[p.1] = p.0
            }

            var isValid = true

            loop:for (p1, i1) in order {
                guard let p2Ar = rules[p1] else { continue }

                for p2 in p2Ar {
                    guard let i2 = order[p2] else { continue }
                    guard i1 < i2 else {
                        isValid = false
                        break loop
                    }
                }
            }

            ans += isValid ? pages[pages.count / 2] : 0
        }

        return ans
    }

    func part2() -> Any {
        var ans = 0

        for pages in input {
            let order = pages.enumerated().reduce(into: [:]) { res, p in
                res[p.1] = p.0
            }

            var isValid = true

            loop:for (p1, i1) in order {
                guard let p2Ar = rules[p1] else { continue }

                for p2 in p2Ar {
                    guard let i2 = order[p2] else { continue }
                    guard i1 < i2 else {
                        isValid = false
                        break loop
                    }
                }
            }

            if !isValid {
                let validated = pages.sorted { p1, p2 in
                    guard let p2Ar = rules[p1], p2Ar.contains(p2),
                          let i1 = order[p1], let i2 = order[p2]
                    else { return true }

                    return i1 < i2
                }
                ans += validated[validated.count / 2]
            }
        }

        return ans
    }
}
