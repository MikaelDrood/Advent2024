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

        var isVertical: Bool {
            switch self {
            case .up, .down: true
            case .left, .right: false
            }
        }
    }

    func part1() -> Any {
        var (map, moves) = parseData()
        var (r, c) = startPosition(map)

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
        }

        return gpsSum(map, "O")
    }

    func part2() -> Any {
        var (map, moves) = parseData(true)
        var (r, c) = startPosition(map)

        snapshot("!", map)

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

        func cascadeShift(_ r: Int, _ c: Int, _ move: Move) -> Bool {
            func canMove(_ r: Int, _ c: Int, _ move: Move) -> Bool {
                guard map[r][c] != "." else { return true }

                let rN = r + move.mut.0, cN = c + move.mut.1

                guard isValid(rN, cN) else { return false }
                guard map[rN][cN] != "." else { return true }
                guard map[rN][cN] != "#" else { return false }

                let cTwin = map[rN][cN] == "[" ? 1 : -1
                return canMove(rN, cN, move) && canMove(rN, cN + cTwin, move)
            }

            var moved: Set<[Int]> = []

            func performMove(_ r: Int, _ c: Int, _ move: Move) {
                guard !moved.contains([r,c]) else { return }

                guard isValid(r, c), map[r][c] != "." else { return }
                let rN = r + move.mut.0, cN = c + move.mut.1
                guard isValid(rN, cN) else { return }

                let cTwin = map[r][c] == "[" ? 1 : -1

                performMove(rN, cN, move)
                performMove(rN, cN + cTwin, move)

                map[rN][cN] = map[r][c]
                map[rN][cN + cTwin] = map[r][cN + cTwin]
                map[r][cN + cTwin] = "."
                map[r][c] = "."
                moved.insert([r,c])
            }

            let rN = r + move.mut.0, cN = c + move.mut.1
            let cTwin = map[rN][cN] == "[" ? 1 : -1

            if canMove(rN, cN, move) &&
               canMove(rN, cN + cTwin, move) {
                performMove(rN, cN, move)
                performMove(rN, cN + cTwin, move)
                map[rN][cN] = map[r][c]
                map[rN][cN + cTwin] = "."
                map[r][c] = "."
                return true
            } else {
                return false
            }
        }

        for move in moves {
            let rN = r + move.mut.0, cN = c + move.mut.1
            guard isValid(rN, cN) else { continue }

            switch map[rN][cN] {
            case "[", "]":
                if move.isVertical {
                    (r, c) = cascadeShift(r, c, move) ? (rN, cN) : (r, c)
                } else {
                    (r, c) = shift(r, c, move)
                }
            case "#":
                continue
            default:
                map[rN][cN] = "@"
                map[r][c] = "."

                r = rN
                c = cN
            }

            //snapshot(move.rawValue, map)
        }

        return gpsSum(map, "[")
    }
}

private extension Day15 {
    func parseData(_ isPt2: Bool = false) -> ([[Character]], [Move]) {
        let comp = data.components(separatedBy: "\n\n")
        let map = comp[0].components(separatedBy: "\n").map { row in
            return if isPt2 {
                Array(row.reduce(into: "") { res, ch in
                    switch ch {
                    case "@": res += "@."
                    case "#": res += "##"
                    case "O": res += "[]"
                    default: res += ".."
                    }
                })
            } else {
                Array(row)
            }
        }
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

    func snapshot(_ m: Character, _ map: [[Character]]) {
        print("\n", m)
        for r in map {
            print(String(r))
        }
    }

    func gpsSum(_ map: [[Character]], _ box: Character) -> Int {
        var gpsSum = 0

        for r in 0 ..< map.count {
            for c in 0 ..< map[0].count {
                gpsSum += map[r][c] == box ?  (100 * r + c) : 0
            }
        }

        return gpsSum
    }
}
