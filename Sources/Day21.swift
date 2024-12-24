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

    struct Node: Comparable, Hashable {
        let r: Int
        let c: Int
        let len: Int
        let seq: [Character]

        static func < (lhs: Day21.Node, rhs: Day21.Node) -> Bool {
            return lhs.len < rhs.len
        }
    }

    func part1() -> Any {
        let codes = parseData()
        var complexity = 0

        for code in codes {
            let seqLen = enter(code)
            complexity += Int(String(code.dropLast())) ?? 0
        }

        return complexity
    }

    func enter(_ code: String) -> Int {
        var (r, c) = (3, 2)
        let node = Node(r: r, c: c, len: 0, seq: [])

        for num in code {
            var heap = Heap<Node>()
            heap.insert(node)

            var visited: Set<Node> = [node]

            while !heap.isEmpty {
                let n = heap.popMin()

            }
        }

        return 0
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
