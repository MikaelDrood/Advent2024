import Algorithms

struct Day10: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String

    func part1() -> Any {
        let m = parseData()
        let rC = m.count, cC = m[0].count

        var score = 0
        var tops: Set<[Int]> = []

        func findTops(_ r: Int, _ c: Int) {
            guard m[r][c] != 9 else {
                tops.insert([r,c])
                return
            }

            for mut in [[-1, 0], [0, 1], [1, 0], [0, -1]] {
                let rN = r + mut[0], cN = c + mut[1]
                guard rN >= 0, rN < rC, cN >= 0, cN < cC,
                      m[rN][cN] - m[r][c] == 1
                else { continue }
                findTops(rN, cN)
            }
        }

        for r in 0 ..< rC {
            for c in 0 ..< cC {
                guard m[r][c] == 0 else { continue }
                findTops(r, c)
                score += tops.count
                tops = []
            }
        }
        return score
    }

    func part2() -> Any {
        let m = parseData()
        let rC = m.count, cC = m[0].count

        var rating = 0

        func findTops(_ r: Int, _ c: Int) {
            guard m[r][c] != 9 else {
                rating += 1
                return
            }

            for mut in [[-1, 0], [0, 1], [1, 0], [0, -1]] {
                let rN = r + mut[0], cN = c + mut[1]
                guard rN >= 0, rN < rC, cN >= 0, cN < cC,
                      m[rN][cN] - m[r][c] == 1
                else { continue }
                findTops(rN, cN)
            }
        }

        for r in 0 ..< rC {
            for c in 0 ..< cC {
                guard m[r][c] == 0 else { continue }
                findTops(r, c)
            }
        }
        return rating
    }
}

private extension Day10 {
    func parseData() -> [[Int]] {
        data.components(separatedBy: "\n")
            .map { s in
                s.utf8CString.dropLast().map { Int($0 - 48) }
            }
    }
}
