//
//  File.swift
//  aoc-2024
//
//  Created by Михаил Баринов on 06.12.2024.
//

import Foundation
import Algorithms

class Day06: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String

    private var m: [[Character]] = []
    private var rC = 0
    private var cC = 0

    private var r = 0
    private var c = 0
    private var dir: Dir = .u

    required init(data: String) {
        self.data = data
        m = parseMap()
        rC = m.count
        cC = m[0].count
        searchStart()
    }

    private func parseMap() -> [[Character]] {
        return data.components(separatedBy: "\n").map { Array($0) }
    }

    enum Dir: String, CaseIterable {
        case u = "^"
        case r = ">"
        case d = "v"
        case l = "<"

        var mut: (Int, Int) {
            return switch self {
            case .u: (-1, 0)
            case .r: (0, 1)
            case .d: (1, 0)
            case .l: (0, -1)
            }
        }

        var turn: Dir {
            return switch self {
            case .u: .r
            case .r: .d
            case .d: .l
            case .l: .u
            }
        }
    }

    func part1() -> Any {
        while isValid(r, c) {
            m[r][c] = "X"
            let (rN, cN) = move(r, c, dir)

            guard isValid(rN, cN) else {
                break
            }

            if isObstacle(rN, cN) {
                dir = dir.turn
            } else {
                r = rN
                c = cN
            }
        }

        return m.reduce(into: 0) { res, row in
            res += row.reduce(into: 0) { res, ch in
                res += ch == "X" ? 1 : 0
            }
        }
    }

    func part2() -> Any {
        let rS = r, cS = c, dirS = dir
        var obs: Set<String> = []

        while isValid(r, c) {
            let (rN, cN) = move(r, c, dir)

            guard isValid(rN, cN) else {
                break
            }

            guard !isObstacle(rN, cN) else {
                dir = dir.turn
                continue
            }

            m[rN][cN] = "#"
            if searchLoop(rS, cS, dirS) {
                obs.insert("\(rN) \(cN)")
            }
            m[rN][cN] = "."

            r = rN
            c = cN
        }

        return obs.count
    }
}

private extension Day06 {

    func searchStart() {
        for i in 0 ..< rC {
            for j in 0 ..< cC {
                if let d = Dir(rawValue: String(m[i][j])) {
                    r = i
                    c = j
                    dir = d
                    return
                }
            }
        }
    }

    func isValid(_ r: Int, _ c: Int) -> Bool {
        return r >= 0 && r < rC && c >= 0 && c < cC
    }

    func isObstacle(_ r: Int, _ c: Int) -> Bool {
        return m[r][c] == "#"
    }

    func move(_ r: Int, _ c: Int, _ dir: Dir) -> (Int, Int) {
        (r + dir.mut.0, c + dir.mut.1)
    }

    func searchLoop(_ r: Int, _ c: Int, _ dir: Dir) -> Bool {
        var r = r, c = c
        var dir = dir
        var path: Set<String> = []

        while isValid(r, c) {
            let k = "\(r)_\(c)_\(dir.rawValue)"

            if path.contains(k) {
                return true
            }

            path.insert(k)

            let (rN, cN) = move(r, c, dir)

            guard isValid(rN, cN) else {
                break
            }

            if isObstacle(rN, cN) {
                dir = dir.turn
            } else {
                r = rN
                c = cN
            }
        }

        return false
    }
}
