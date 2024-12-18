
import Algorithms
import Collections

struct Day18: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String

    struct Node: Comparable {
        let r: Int
        let c: Int
        let steps: Int

        static func < (lhs: Day18.Node, rhs: Day18.Node) -> Bool {
            lhs.steps < rhs.steps
        }
    }

    func part1() -> Any {
        let size = 71, bytes = 1024
        //let size = 7, bytes = 12
        var map: [[Character]] = Array(repeating: Array(repeating: ".", count: size),
                                       count: size)

        for (rB, cB) in parseData()[0..<bytes] {
            map[rB][cB] = "#"
        }

        return searchPath(map: map) ?? 0
    }

    func part2() -> Any {
        //let size = 71, bytes = 1024
        let size = 7, bytes = 12
        var map: [[Character]] = Array(repeating: Array(repeating: ".", count: size),
                                       count: size)
        let fallingBytes = parseData()

        for (rB, cB) in fallingBytes[0..<bytes]{
            map[rB][cB] = "#"
        }

        for i in bytes ..< fallingBytes.count {
            let (rB, cB) = fallingBytes[i]
            map[rB][cB] = "#"
            let steps = searchPath(map: map)

            if steps == -1 {
                return "\(cB),\(rB)"
            }
        }

        return -1
    }
}

private extension Day18 {
    func parseData() -> [(Int, Int)] {
        return data.components(separatedBy: "\n").map {
            let coord = $0.components(separatedBy: ",")
            return (Int(coord[1])!, Int(coord[0])!)
        }
    }

    func snapshot(_ map: [[Character]]) {
        for r in map {
            print(String(r))
        }
    }

    func searchPath(map: [[Character]]) -> Int? {
        let size = map.count
        var steps: [String: Int] = [:]
        var queue = Heap<Node>()

        queue.insert(Node(r: 0, c: 0, steps: 0))

        while !queue.isEmpty {
            let node = queue.popMin()!

            guard node.r >= 0, node.r < size, node.c >= 0, node.c < size,
                  map[node.r][node.c] == "."
            else { continue }

            let k = "\(node.r)_\(node.c)"

            let visited = steps[k, default: Int.max]
            guard node.steps < visited else { continue }

            steps[k] = node.steps

            [(-1, 0), (0, 1), (1, 0), (0, -1)].forEach { (rr, cc) in
                let n = Node(r: node.r + rr, c: node.c + cc, steps: node.steps + 1)
                queue.insert(n)
            }
        }

        return steps["\(size - 1)_\(size - 1)", default: -1]
    }
}
