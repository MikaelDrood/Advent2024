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

    static func distance(_ dir: Character) -> Int {
        let coords = coords[Dir(rawValue: dir)!]!
        return abs(0 - coords.0) + abs(2 - coords.1)
    }

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

        var priority: Int {
            switch self {
            case .right: 3
            case .up: 2
            case .down: 1
            case .left: 0
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
            print(seqLen, Int(String(code.dropLast()))!)
            complexity += Int(String(code.dropLast()))! * seqLen
        }

        return complexity
    }

    func enter(_ code: String) -> Int {
        let numPath = searchPath(Self.numeric, code, (3, 2))
        let roboPath = searchPath(Self.directional, numPath, (0, 2))
        let historiansPath = searchPath(Self.directional, roboPath, (0, 2))

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
            heap.insert(Node(r: r, c: c, len: 0, seq: ""))

            var visited: [Node: Int] = [:]

            while !heap.isEmpty {
                let n = heap.popMin()!

                guard isValid(n, map) else { continue }

                let memoLen = visited[n, default: Int.max]
                guard n.len < memoLen else { continue }

                visited[n] = n.len

                guard map[n.r][n.c] != String(sym) else {
                    r = n.r
                    c = n.c
                    path += n.seq.sorted(by: {
                        //Self.distance($0) < Self.distance($1)
                        Dir(rawValue: $0)!.priority > Dir(rawValue: $1)!.priority
                    }) + "A"
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
