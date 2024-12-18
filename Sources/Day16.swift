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

        private func isOpposite(_ dir: Dir) -> Bool {
            switch self {
            case .up: dir == .down
            case .right: dir == .left
            case .down: dir == .down
            case .left: dir == .right
            }
        }

        func turn(_ dir: Dir) -> (Dir, Int) {
            let cost = if self == dir {
                0
            } else if self.isOpposite(dir) {
                2000
            } else {
                1000
            }
            return (dir, cost)
        }
    }

    func part1() -> Any {
        var map = parseData()

        let start = searchStart(map)
        map[start.0][start.1] = "."
        
        var minCost = Int.max
        var memo: [String: Int] = [:]

        func search(_ r: Int, _ c: Int, _ cost: Int, _ dir: Dir) {
            guard map[r][c] != "E" else {
                minCost = min(minCost, cost)
                return
            }

            guard map[r][c] == "." else { return }

            let k = "\(r)_\(c)_\(dir.rawValue)"
            if let m = memo[k], m < cost {
                return
            } else {
                memo[k] = cost
            }

            Dir.allCases.forEach { newDir in
                let (d2, turnCost) = dir.turn(newDir)
                map[r][c] = d2.rawValue
                search(r + d2.move.0, c + d2.move.1, cost + turnCost + 1, d2)
                map[r][c] = "."
            }
        }

        search(start.0, start.1, 0, .right)
        return minCost
    }

    func part2() -> Any {
        var map = parseData()

        let start = searchStart(map)
        map[start.0][start.1] = "."

        var minCost = Int.max
        var memo: [String: Int] = [:]

        var tiles: Set<String> = []
        var pathTiles: Set<String> = []

        func search(_ r: Int, _ c: Int, _ cost: Int, _ dir: Dir) {
            guard map[r][c] != "E" else {
                if cost <= minCost {
                    tiles = cost < minCost ? pathTiles : tiles.union(pathTiles)
                    minCost = cost
                }
                return
            }

            guard map[r][c] == "." else { return }

            let pathKey = "\(r)_\(c)"
            pathTiles.insert(pathKey)

            let k = "\(r)_\(c)_\(dir.rawValue)"
            if let m = memo[k], m < cost {
                pathTiles.remove(pathKey)
                return
            } else {
                memo[k] = cost
            }

            Dir.allCases.forEach { newDir in
                let (d2, turnCost) = dir.turn(newDir)
                map[r][c] = d2.rawValue
                search(r + d2.move.0, c + d2.move.1, cost + turnCost + 1, d2)
                map[r][c] = "."
            }

            pathTiles.remove(pathKey)
        }

        search(start.0, start.1, 0, .right)

        return tiles.count + 1
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
