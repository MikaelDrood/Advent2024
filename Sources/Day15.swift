import Algorithms

struct Day15: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String

    enum Move: Character {
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

    func part1() -> Any {
        var (map, moves) = parseData()
        var (r, c) = startPosition(map)

        func snapshot(_ m: Character) {
            print("\n", m)
            for r in map {
                print(String(r))
            }
        }

        let rC = map.count, cC = map[0].count

        func isValid(_ r: Int, _ c: Int) -> Bool {
            r >= 0 && r < rC && c >= 0 && c < cC
        }

        func shift(_ r: Int, _ c: Int, _ move: Move) -> (Int, Int) {
            var rM = r, cM = c
            var gotSpace = false

            while isValid(rM, cM), map[rM][cM] != "#" {
                guard map[rM][cM] != "." else {
                    gotSpace = true
                    break
                }

                rM += move.mut.0
                cM += move.mut.1
            }

            guard gotSpace else {
                return (r, c)
            }

            while map[rM][cM] != "@" {
                map[rM][cM] = map[rM - move.mut.0][cM - move.mut.1]
                rM -= move.mut.0
                cM -= move.mut.1
            }

            map[rM][cM] = "."
            return (rM + move.mut.0, cM + move.mut.1)
        }

        for move in moves {
            let rN = r + move.mut.0, cN = c + move.mut.1
            guard isValid(rN, cN) else { continue }

            switch map[rN][cN] {
            case "O":
                (r, c) = shift(r, c, move)
            case "#":
                continue
            default:
                map[rN][cN] = "@"
                map[r][c] = "."

                r = rN
                c = cN
            }

            //snapshot(move.rawValue)
        }

        var gpsSum = 0

        for r in 0 ..< rC {
            for c in 0 ..< cC {
                gpsSum += map[r][c] == "O" ?  (100 * r + c) : 0
            }
        }

        return gpsSum
    }

    func part2() -> Any {
        return 0
    }
}

private extension Day15 {
    func parseData() -> ([[Character]], [Move]) {
        let comp = data.components(separatedBy: "\n\n")
        let map = comp[0].components(separatedBy: "\n").map { Array($0) }
        let moves = comp[1].compactMap { Move(rawValue: $0) }

        return (map, moves)
    }

    func startPosition(_ map: [[Character]]) -> (Int, Int) {
        for r in 0 ..< map.count {
            for c in 0 ..< map[0].count {
                if map[r][c] == "@" {
                    return (r, c)
                }
            }
        }

        return (1,1)
    }
}
