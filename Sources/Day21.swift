import Algorithms

struct Day21: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String

    static let numeric = [["7", "8", "9"],
                          ["4", "5", "6"],
                          ["1", "2", "3"],
                          ["", "0", "A"]]
    static let directional = [["", "^", "A"],
                              ["<", "v", ">"]]

    static let coords: [Dir: (Int, Int)] = {
        var coords: [Dir: (Int, Int)] = [:]

        for r in 0 ..< directional.count {
            for c in 0 ..< directional[0].count {
                guard let ch = directional[r][c].first,
                      let dir = Dir(rawValue: ch)
                else { continue }

                coords[dir] = (r, c)
            }
        }

        return coords
    }()

    enum Dir: Character, CaseIterable {
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
            complexity += Int(String(code.dropLast()))! * seqLen
        }

        return complexity
    }

    func enter(_ code: String) -> Int {
        var minPathLen = Int.max

        for numPath in searchPath(Self.numeric, code, (3, 2), true) {
            for roboPath in searchPath(Self.directional, numPath, (0, 2), true) {
                let histoPath = searchPath(Self.directional, roboPath, (0, 2), false).first!
                minPathLen = min(minPathLen, histoPath.count)
            }
        }

        print(minPathLen, code)

        return minPathLen
    }

    func searchPath(_ pad: [[String]], _ word: String, _ start: (Int, Int), _ permutate: Bool) -> [String] {
        var (r, c) = start
        var paths: [String] = []

        for sym in word {
            var heap = Heap<Node>()
            heap.insert(Node(r: r, c: c, len: 0, seq: ""))

            var visited: [Node: Int] = [:]

            while !heap.isEmpty {
                let n = heap.popMin()!

                guard isValid(n, pad) else { continue }

                let memoLen = visited[n, default: Int.max]
                guard n.len < memoLen else { continue }

                visited[n] = n.len

                guard pad[n.r][n.c] != String(sym) else {
                    defer {
                        r = n.r
                        c = n.c
                    }

                    let asc = String(n.seq.sorted(by: >) + "A")
                    let desc = String(n.seq.sorted(by: <) + "A")

                    let subPaths = Array(Set([asc, desc])).filter { isValid($0, pad, (r, c)) }

                    guard permutate else {
                        paths = subPaths.map { (paths.first ?? "") + $0 }
                        break
                    }

                    if paths.isEmpty {
                        paths = subPaths
                    } else {
                        paths = paths.flatMap { p in
                            subPaths.map { p + $0 }
                        }
                    }

                    break
                }

                Dir.allCases.forEach { dir in
                    let next = Node(r: n.r + dir.mut.0,
                                    c: n.c + dir.mut.1,
                                    len: n.len + 1,
                                    seq: n.seq + String(dir.rawValue))
                    heap.insert(next)
                }
            }
        }

        return paths
    }

    func isValid(_ node: Node, _ pad: [[String]]) -> Bool {
        return node.r >= 0 && 
               node.r < pad.count &&
               node.c >= 0 &&
               node.c < pad[0].count
    }

    func isValid(_ path: String, _ pad: [[String]], _ start: (Int, Int)) -> Bool {
        var (r, c) = start

        for ch in path {
            guard let dir = Dir(rawValue: ch) else { continue }

            r += dir.mut.0
            c += dir.mut.1

            if pad[r][c] == "" {
                return false
            }
        }

        return true
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
