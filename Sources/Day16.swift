import Algorithms

struct Day16: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String

    enum Dir: Character, CaseIterable {
        case up = "^"
        case left = "<"
        case down = "v"
        case right = ">"

        var move: (Int, Int) {
            switch self {
            case .left: (0, -1)
            case .up: (-1, 0)
            case .right: (0, 1)
            case .down: (1, 0)
            }
        }

        var opposite: Dir {
            switch self {
            case .up: .down
            case .down: .up
            case .left: .right
            case .right: .left
            }
        }

        func apply(_ dir: Dir) -> (Dir, Int) {
            let cost = switch self {
            case .up:
                switch dir {
                case .up: 0
                case .down: 2000
                case .left, .right: 1000
                }
            case .right:
                switch dir {
                case .up, .down: 1000
                case .right: 0
                case .left: 2000
                }
            case .down:
                switch dir {
                case .down: 0
                case .up: 2000
                case .left, .right: 1000
                }
            case .left:
                switch dir {
                case .left: 0
                case .up, .down: 1000
                case .right: 2000
                }
            }
            return (dir, cost)
        }
    }

    func part1() -> Any {
        var map = parseData()

        let start = searchStart(map)
        map[start.0][start.1] = "."

        var memo: [String: Int] = [:]

        func search(_ r: Int, _ c: Int, _ dir: Dir) -> Int {
            guard map[r][c] != "E" else {
                //snapshot(map)
                return 0
            }

            guard map[r][c] == "." else { return -1 }

            let k = "\(r)_\(c)_\(dir.rawValue)"
            if let m = memo[k] {
                //snapshot(map)
                return m
            }

            var minPoints = -1

            Dir.allCases.forEach { turn in
                //guard dir.opposite != turn else { return }

                let (d2, turnCost) = dir.apply(turn)
                map[r][c] = d2.rawValue
                let points = search(r + d2.move.0, c + d2.move.1, d2)
                map[r][c] = "."

                if points == -1 {
                    // do nothing
                } else if minPoints == -1 {
                    minPoints = turnCost + 1 + points
                } else {
                    minPoints = min(minPoints, turnCost + 1 + points)
                }
            }

            memo[k] = minPoints
            return minPoints
        }

        return search(start.0, start.1, .right)
    }

    func part2() -> Any {
        return 0
    }
}

private extension Day16 {
    func parseData() -> [[Character]] {
        data.components(separatedBy: "\n").map { Array($0) }
    }

    func searchStart(_ m: [[Character]]) -> (Int, Int) {
        for r in 0 ..< m.count {
            for c in 0 ..< m[0].count {
                switch m[r][c] {
                case "S": return (r, c)
                default: continue
                }
            }
        }

        return (0, 0)
    }

    func snapshot(_ map: [[Character]]) {
        for r in map {
            print(String(r))
        }
    }
}
