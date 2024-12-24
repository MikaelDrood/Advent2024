import Algorithms

struct Day21: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String

    let numeric = [["7", "8", "9"],
                   ["4", "5", "6"],
                   ["1", "2", "3"],
                   ["", "0", "A"]]
    let directional = [["", "^", "A"],
                       ["<", "v", ">"]]

    enum Dir: String, CaseIterable {
        case up = "^"
        case right = ">"
        case down = "v"
        case left = "<"

        var mut: (Int, Int) {
            switch self {
            case .up: (-1, 0)
            case .right: (0, 1)
            case .down: (1, 0)
            case .left: (0, -1)
            }
        }
    }

    struct Node: Comparable, Hashable {
        let r: Int
        let c: Int
        let len: Int
        let seq: String

        static func < (lhs: Day21.Node, rhs: Day21.Node) -> Bool {
            return lhs.len < rhs.len
        }

        func hash(into hasher: inout Hasher) {
            hasher.combine(r)
            hasher.combine(c)
        }
    }

    func part1() -> Any {
        let codes = parseData()
        var complexity = 0

        for code in codes {
            let seqLen = enter(code)
            complexity += (Int(String(code.dropLast())) ?? 0) * seqLen
        }

        return complexity
    }

    func enter(_ code: String) -> Int {
        let numPath = searchPath(numeric, code, (3, 2))
        let roboPath = searchPath(directional, numPath, (0, 2))
        let historiansPath = searchPath(directional, roboPath, (0, 2))

        print(numPath, numPath.count)
        print(roboPath, roboPath.count)
        print(historiansPath, historiansPath.count)

        return historiansPath.count
    }

    func searchPath(_ map: [[String]], _ word: String, _ start: (Int, Int)) -> String {
        var (r, c) = start
        var path = ""

        for sym in word {
            var heap = Heap<Node>()
            heap.insert(Node(r: r, c: c, len: 0, seq: path))

            var visited: [Node: Int] = [:]

            while !heap.isEmpty {
                let n = heap.popMin()!

                guard isValid(n, map) else { continue }

                let memoLen = visited[n, default: Int.max]
                guard n.len <= memoLen else { continue }

                visited[n] = n.len

                guard map[n.r][n.c] != String(sym) else {
                    r = n.r
                    c = n.c
                    path = n.seq + "A"
                    break
                }

                Dir.allCases.forEach { dir in
                    let next = Node(r: n.r + dir.mut.0,
                                    c: n.c + dir.mut.1,
                                    len: n.len + 1,
                                    seq: n.seq + dir.rawValue)
                    heap.insert(next)
                }
            }
        }

        return path
    }

    func isValid(_ node: Node, _ pad: [[String]]) -> Bool {
        return node.r >= 0 && 
               node.r < pad.count &&
               node.c >= 0 &&
               node.c < pad[0].count &&
               pad[node.r][node.c] != ""
    }

    func part2() -> Any {
        return 0
    }
}

private extension Day21 {
    func parseData() -> [String] {
        return data.components(separatedBy: "\n")
    }
}
