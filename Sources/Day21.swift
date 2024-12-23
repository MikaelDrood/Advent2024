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

        //let numPath = searchPath(Self.numeric, code, (3, 2))
        for numPath in searchPath(Self.numeric, code, (3, 2), true) {//permutate(numPath) {
            print("N: ", numPath)
            guard isValid(numPath, Self.numeric, (3, 2)) else { continue }
            print("Valid")
            //let roboPath = searchPath(Self.directional, numPath, (0, 2))
            for roboPath in searchPath(Self.directional, numPath, (0, 2), true) {//permutate(roboPath) {
                //print("R: ", roboPath)
                guard isValid(roboPath, Self.directional, (0,2)) else { continue }
                //print("Valid")

                let histoPath = searchPath(Self.directional, roboPath, (0, 2), false).first!
                //guard isValid(histoPath, Self.directional) else { continue }
                //print("H: ", histoPath, histoPath.count)
                minPathLen = min(minPathLen, histoPath.count)
            }
        }

        print(minPathLen, code)

        return minPathLen
    }

    func searchPath(_ map: [[String]], _ word: String, _ start: (Int, Int), _ permutate: Bool) -> [String] {
        var (r, c) = start
        var paths: [String] = []

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

                    guard permutate else {
                        paths = [(paths.first ?? "") + n.seq + "A"]
                        break
                    }

                    if paths.isEmpty {
                        if Set(n.seq).count == 1 {
                            paths.append(n.seq.sorted(by: >) + "A")
                        } else {
                            paths.append(n.seq.sorted(by: >) + "A")
                            paths.append(n.seq.sorted(by: <) + "A")
                        }
                    } else {
                        var permutations: [String] = []
                        paths.forEach { permutations.append($0 + n.seq.sorted(by: >) + "A") }
                        paths.forEach { permutations.append($0 + n.seq.sorted(by: <) + "A") }
                        //path += n.seq.sorted() + "A"
                        paths = permutations
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
