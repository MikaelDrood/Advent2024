import Algorithms

class Day20: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    let data: String
    var map: [[Character]] = []
    var path: [Node] = []
    var rC = 0
    var cC = 0

    var seconds: [String: Int] = [:]
    let savedSeconds = 100
    var cheatsCount = 0

    class Node {
        let r: Int
        let c: Int
        let second: Int
        let prev: Node?

        init(r: Int, c: Int, second: Int, prev: Node? = nil) {
            self.r = r
            self.c = c
            self.second = second
            self.prev = prev
        }
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
        runCheatAnalysis2()

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

            guard seconds[k] == nil, isValid(n.r, n.c), map[n.r][n.c] != "#" else { continue }
            path.append(n)

            seconds[k] = n.second
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

            guard n.second == seconds[k] else {
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

            guard let m = seconds[k] else { return }
            cheatsCount += (m - n.second - 1 >= savedSeconds) ? 1 : 0
        }
    }
    func runCheatAnalysis2() {
        for n in path {
            let size = 20
            for rr in -size ... size {
                for cc in -(size - abs(rr)) ... size - abs(rr) {
                    let r = n.r + rr, c = n.c + cc

                    guard let second = seconds["\(r)_\(c)"] else { continue }
//                    if second - n.second - abs(r - n.r) - abs(c - n.c) >= savedSeconds {
//                        map[n.r][n.c] = "J"
//                        map[r][c] = "J"
//                        snapshot(map)
//                        map[n.r][n.c] = "."
//                        map[r][c] = "."
//                    }
                    cheatsCount += second - n.second - abs(r - n.r) - abs(c - n.c) >= savedSeconds ? 1 : 0
                }
            }
        }
    }

//    func runCheatAnalysis2(_ start: (Int, Int)) {
//        for i in 0 ..< path.count {
//            let nI = path[i]
//            let kI = "\(nI.r)_\(nI.c)"
//
//            let wallsI = [(-1, 0), (0, -1), (0, 1), (1, 0)].compactMap { mut in
//                let next = Node(r: nI.r + mut.0, c: nI.c + mut.1, second: nI.second + 1)
//                return map[next.r][next.c] == "#" ? next : nil
//            }
//
//            for j in i + 1 ..< path.count {
//                let nJ = path[j]
//                let kJ = "\(nJ.r)_\(nJ.c)"
//
//                let wallsJ = [(-1, 0), (0, -1), (0, 1), (1, 0)].compactMap { mut in
//                    let next = Node(r: nJ.r + mut.0, c: nJ.c + mut.1, second: nJ.second + 1)
//                    return map[next.r][next.c] == "#" ? next : nil
//                }
//
//                loop:for wallI in wallsI {
//                    for wallJ in wallsJ {
//                        let dist = abs(wallJ.r - wallI.r) + abs(wallJ.c - wallI.c) + 2
//
//                        guard dist <= 20 else { continue }
//
//                        if seconds[kJ]! - seconds[kI]! - dist == savedSeconds {
//                            //print(kI, kJ)
//                            cheatsCount += 1
//                            break loop
//                        }
//                    }
//                }
//            }
//        }
//    }

    func isValid(_ r: Int, _ c: Int) -> Bool {
        return r >= 0 && r < rC && c >= 0 && c < cC
    }

    func snapshot(_ map: [[Character]]) {
        for r in map {
            print(String(r))
        }
    }
}
