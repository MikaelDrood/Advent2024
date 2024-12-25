import Algorithms

struct Day25: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String

    func part1() -> Any {
        var matches = 0

        let (locks, keys, height) = parseData()
        for lock in locks {
            for key in keys {
                matches += zip(lock, key).allSatisfy { $0 + $1 <= height } ? 1 : 0
            }
        }

        return matches
    }

    func part2() -> Any {
        return 0
    }
}

private extension Day25 {
    func parseData() -> ([[Int]], [[Int]], Int) {
        let data = data.components(separatedBy: "\n\n")

        var locks: [[Int]] = []
        var keys: [[Int]] = []

        let maps: [[[Character]]] = data.map {
            let rows = $0.components(separatedBy: "\n")
            return rows.map { Array($0) }
        }

        for m in maps {
            var input: [Int] = []

            for c in 0 ..< m[0].count {
                var h = 0
                for r in 0 ..< m.count {
                    h += m[r][c] == "#" ? 1 : 0
                }
                input.append(h)
            }

            if m[0].allSatisfy({ $0 == "#" }) {
                locks.append(input)
            } else {
                keys.append(input)
            }
        }

        return (locks, keys, maps[0].count)
    }
}
