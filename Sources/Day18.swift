
import Algorithms

struct Day18: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String

    enum Dir: CaseIterable {
        case up
        case right
        case down
        case left

        var move: (Int, Int) {
            switch self {
            case .left: (0, -1)
            case .up: (-1, 0)
            case .right: (0, 1)
            case .down: (1, 0)
            }
        }
    }

    func part1() -> Any {
        let size = 71
        let falling: [(Int, Int)] = parseData()

        var map: [[Character]] = Array(repeating: Array(repeating: ".", count: size),
                                       count: size)
        var steps = Int.max
        var memo: [String: Int] = [:]

        for i in 0 ..< 1024 {
            let (rB, cB) = falling[i]
            map[rB][cB] = "#"
        }

        func run(_ r: Int, _ c: Int, _ turn: Int) {
            if r == size - 1, c == size - 1 {
                print(turn)
                snapshot(map)
                steps = min(steps, turn)
                return
            }

            guard r >= 0, r < size, c >= 0, c < size else { return }
            guard map[r][c] == "." else { return }

            let k = "\(r)_\(c)"
            if let m = memo[k], m < turn {
                return
            } else {
               memo[k] = turn
            }

            map[r][c] = "o"
            Dir.allCases.forEach { mut in
                run(r + mut.move.0, c + mut.move.1, turn + 1)
            }
            map[r][c] = "."
        }

        run(0, 0, 0)
        return steps
    }

    func part2() -> Any {
        return 0
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
}
