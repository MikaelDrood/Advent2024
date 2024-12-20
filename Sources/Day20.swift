import Algorithms

class Day20: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    let data: String
    var map: [[Character]] = []
    var rC = 0
    var cC = 0

    var memo: [String: Int] = [:]
    let savedSeconds = 32
    var cheatsCount = 0

    struct Node {
        let r: Int
        let c: Int
        let second: Int
    }

    required init(data: String) {
        self.data = data
        map = parseData()
        rC = map.count
        cC = map[0].count
    }

    func part1() -> Any {
        let (start, _) = searchStartFinish(map)
        run(start)
        runCheatAnalysis(start)

        return cheatsCount
    }

    func part2() -> Any {
        let (start, _) = searchStartFinish(map)
        run(start)
        runCheatAnalysis2(start)

        return cheatsCount
    }

}

private extension Day20 {
    func parseData() -> [[Character]] {
        data.components(separatedBy: "\n").map { Array($0) }
    }

    func searchStartFinish(_ m: [[Character]]) -> ((Int, Int), (Int, Int)) {
        var start: (Int, Int) = (0, 0), finish: (Int, Int) = (0, 0)

        for r in 0 ..< m.count {
            for c in 0 ..< m[0].count {
                switch m[r][c] {
                case "S": start = (r, c)
                case "E": finish = (r, c)
                default: continue
                }
            }
        }

        return (start, finish)
    }

    func run(_ start: (Int, Int)) {
        var q = [Node(r: start.0, c: start.1, second: 0)]
        while !q.isEmpty {
            let n = q.removeFirst()
            let k = "\(n.r)_\(n.c)"

            guard memo[k] == nil, isValid(n.r, n.c), map[n.r][n.c] != "#" else { continue }

            memo[k] = n.second
            [(-1, 0), (0, 1), (1, 0), (0, -1)].forEach { (rM, cM) in
                let r = n.r + rM, c = n.c + cM
                q.append(Node(r: r, c: c, second: n.second + 1))
            }
        }
    }

    func runCheatAnalysis(_ start: (Int, Int)) {
        var q = [Node(r: start.0, c: start.1, second: 0)]
        while !q.isEmpty {
            let n = q.removeFirst()
            let k = "\(n.r)_\(n.c)"

            guard isValid(n.r, n.c) else { continue }

            guard let m = memo[k], m == n.second else {
                if map[n.r][n.c] == "#" {
                    checkShortcut(n)
                }
                continue
            }

            [(-1, 0), (0, 1), (1, 0), (0, -1)].forEach { (rM, cM) in
                let r = n.r + rM, c = n.c + cM
                q.append(Node(r: r, c: c, second: n.second + 1))
            }
        }
    }

    func checkShortcut(_ n: Node) {
        [(-1, 0), (0, -1), (0, 1), (1, 0)].forEach { mut in
            let k = "\(n.r + mut.0)_\(n.c + mut.1)"

            guard let m = memo[k] else { return }
            cheatsCount += (m - n.second - 1 >= savedSeconds) ? 1 : 0
        }
    }

    func runCheatAnalysis2(_ start: (Int, Int)) {
        var q = [Node(r: start.0, c: start.1, second: 0)]
        while !q.isEmpty {
            let n = q.removeFirst()
            let k = "\(n.r)_\(n.c)"

            guard isValid(n.r, n.c), n.second == memo[k] else { continue }

            checkShortcut2(n)

            [(-1, 0), (0, 1), (1, 0), (0, -1)].forEach { (rM, cM) in
                let r = n.r + rM, c = n.c + cM
                q.append(Node(r: r, c: c, second: n.second + 1))
            }
        }
    }

    func checkShortcut2(_ n: Node) {
        let size = 20
        for rr in -size ... size {
            for cc in -(size - abs(rr)) ... size - abs(rr) {
                let r = n.r + rr, c = n.c + cc

                guard isValid(r, c) else { continue }

                let k = "\(r)_\(c)"
                guard let second = memo[k] else { continue }

                cheatsCount += second - n.second == savedSeconds ? 1 : 0
            }
        }
    }

    func isValid(_ r: Int, _ c: Int) -> Bool {
        return r >= 0 && r < rC && c >= 0 && c < cC
    }
}
