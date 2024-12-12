import Algorithms

struct Day12: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String

    func part1() -> Any {
        let data = parseData()
        let rC = data.count, cC = data[0].count

        var visited: Set<[Int]> = []
        var p: [Int: Int] = [:]
        var s: [Int: Int] = [:]

        func research(_ r: Int, _ c: Int, _ ch: Character, _ id: Int) {
            guard r >= 0, r < rC, c >= 0, c < cC else {
                p[id, default: 0] += 1
                return
            }

            guard !visited.contains([r, c]) else {
                p[id, default: 0] += data[r][c] == ch ? 0 : 1
                return
            }

            guard data[r][c] == ch else {
                p[id, default: 0] += 1
                return
            }

            visited.insert([r, c])
            s[id, default: 0] += 1

            for mut in [[-1, 0], [0,1], [1, 0], [0, -1]] {
                let rr = r + mut[0], cc = c + mut[1]
                research(rr, cc, ch, id)
            }
        }

        var id = 0
        for r in 0 ..< rC {
            for c in 0 ..< cC {
                guard !visited.contains([r, c]) else { continue }
                research(r, c, data[r][c], id)
                id += 1
            }
        }

        return s.reduce(into: 0) { res, plot in
            res += plot.value * p[plot.key]!
        }
    }

    func part2() -> Any {
        let data = parseData()
        let rC = data.count, cC = data[0].count

        var visited: Set<[Int]> = []
        var сrn: [Int: Int] = [:]
        var s: [Int: Int] = [:]

        func isValid(_ r: Int, _ c: Int) -> Bool {
            return r >= 0 && r < rC && c >= 0 && c < cC
        }

        func countCorners(_ r: Int, _ c: Int) -> Int {
            let ch = data[r][c]

            var count = 0
            count += (!isValid(r - 1, c) || data[r - 1][c] != ch) &&
                     (!isValid(r, c - 1) || data[r][c - 1] != ch) ? 1 : 0
            count += (isValid(r - 1, c) && data[r - 1][c] == ch) &&
                     (isValid(r, c - 1) && data[r][c - 1] == ch) &&
                     (data[r - 1][c - 1] != ch) ? 1 : 0
            count += (!isValid(r - 1, c) || data[r - 1][c] != ch) &&
                     (!isValid(r, c + 1) || data[r][c + 1] != ch) ? 1 : 0
            count += (isValid(r - 1, c) && data[r - 1][c] == ch) &&
                     (isValid(r, c + 1) && data[r][c + 1] == ch) &&
                      data[r - 1][c + 1] != ch ? 1 : 0
            count += (!isValid(r, c + 1) || data[r][c + 1] != ch) &&
                     (!isValid(r + 1, c) || data[r + 1][c] != ch) ? 1 : 0
            count += (isValid(r, c + 1) && data[r][c + 1] == ch) &&
                     (isValid(r + 1, c) && data[r + 1][c] == ch) &&
                     data[r + 1][c + 1] != ch ? 1 : 0
            count += (!isValid(r + 1, c) || data[r + 1][c] != ch) &&
                     (!isValid(r, c - 1) || data[r][c - 1] != ch) ? 1 : 0
            count += (isValid(r + 1, c) && data[r + 1][c] == ch) &&
                     (isValid(r, c - 1) && data[r][c - 1] == ch) &&
                     data[r + 1][c - 1] != ch ? 1 : 0
            return count
        }

        func research(_ r: Int, _ c: Int, _ ch: Character, _ id: Int) {
            guard isValid(r, c),
                  !visited.contains([r, c]),
                  data[r][c] == ch
            else { return }

            visited.insert([r, c])

            s[id, default: 0] += 1
            сrn[id, default: 0] += countCorners(r, c)

            for mut in [[-1, 0], [0,1], [1, 0], [0, -1]] {
                let rr = r + mut[0], cc = c + mut[1]
                research(rr, cc, ch, id)
            }
        }

        var id = 0
        for r in 0 ..< rC {
            for c in 0 ..< cC {
                guard !visited.contains([r, c]) else { continue }
                let ch = data[r][c]
                research(r, c, ch, id)
                id += 1
            }
        }

        return s.reduce(into: 0) { res, plot in
            res += plot.value * сrn[plot.key]!
        }
    }
}

private extension Day12 {
    func parseData() -> [[Character]] {
        data.components(separatedBy: "\n").map { Array($0) }
    }
}
