import Algorithms

struct Day01: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String

    var entities: [[Int]] {
        let components = data.components(separatedBy: "\n")
            .flatMap {
                $0.components(separatedBy: " ")
            }
            .compactMap { Int($0) }

        var l1: [Int] = [], l2: [Int] = []
        for (i, n) in components.enumerated() {
            i % 2 == 0 ? l1.append(n) : l2.append(n)
        }

        return [l1, l2]
    }

    func part1() -> Any {
        return zip(entities[0].sorted(), entities[1].sorted()).reduce(into: 0) { res, p in
            res += abs(p.0 - p.1)
        }
    }

    func part2() -> Any {
        let freq = entities[1].reduce(into: [:]) { res, n in
            res[n, default: 0] += 1
        }

        return entities[0].reduce(into: 0) { res, n in
            res += (freq[n] ?? 0) * n
        }
    }
}
