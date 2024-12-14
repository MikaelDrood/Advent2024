import Algorithms
import RegexBuilder

struct Day14: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String

    struct Robot {
        let vX: Int
        let vY: Int
        var x: Int
        var y: Int
    }

    func part1() -> Any {
        let r = 103, c = 101
        let time = 100

        let robots = parseData()
        var f1 = 0, f2 = 0, f3 = 0, f4 = 0

        for i in 0 ..< robots.count {
            var x = (robots[i].x + time * robots[i].vX) % c
            var y = (robots[i].y + time * robots[i].vY) % r

            x = x >= 0 ? x : c + x
            y = y >= 0 ? y : r + y

            f1 += x < c / 2 && y < r / 2 ? 1 : 0
            f2 += x > c / 2 && y < r / 2 ? 1 : 0
            f3 += x < c / 2 && y > r / 2 ? 1 : 0
            f4 += x > c / 2 && y > r / 2 ? 1 : 0
        }

        return f1 * f2 * f3 * f4
    }

    func part2() -> Any {
        let xC = 101, yC = 103

        var robots = parseData()
        let rCount = robots.count

        var m = Array(repeating: Array(repeating: 0, count: xC), count: yC)
        var visited: Set<String> = []

        func dfs(_ y: Int, _ x: Int) -> Int {
            let k = "\(y) \(x)"
            guard !visited.contains(k) else { return 0 }

            guard y >= 0, y < yC, x >= 0, x < xC else { return 0 }
            guard m[y][x] != 0 else { return 0 }

            visited.insert(k)

            return 1 + dfs(y + 1, x - 1) + dfs(y + 1, x) + dfs(y + 1, x + 1)
        }

        for turn in 0 ..< Int.max {
            for i in 0 ..< robots.count {
                var x = robots[i].x, y = robots[i].y

                m[y][x] -= 1
                m[y][x] = max(m[y][x], 0)

                x = (robots[i].x + robots[i].vX) % xC
                y = (robots[i].y + robots[i].vY) % yC

                x = x >= 0 ? x : xC + x
                y = y >= 0 ? y : yC + y

                robots[i].x = x
                robots[i].y = y

                m[y][x] += 1
            }

            for yy in 0 ..< yC {
                for xx in 0 ..< xC {
                    guard m[yy][xx] != 0 else { continue }

                    visited = []
                    let cloud = dfs(yy, xx)

                    guard cloud >= rCount / 3 else { continue }

                    let prnt = m.reduce(into: "") { res, row in
                        res += "\n" + row.map { $0 == 0 ? "." : "\($0)" }.joined()
                    }

                    print(prnt)

                    return turn + 1
                }
            }
        }

        return -1
    }
}

private extension Day14 {
    func parseData() -> [Robot] {
        let regex = Regex {
            "p="
            Capture { OneOrMore(.digit) }
            ","
            Capture { OneOrMore(.digit) }
            " v="
            Capture {
                Optionally { "-" }
                OneOrMore(.digit)
            }
            ","
            Capture {
                Optionally { "-" }
                OneOrMore(.digit)
            }
            ZeroOrMore { "\n" }
        }

        var robots: [Robot] = []

        for match in data.matches(of: regex) {
            let x = Int(match.1)!, y = Int(match.2)!
            let vX = Int(match.3)!, vY = Int(match.4)!

            let robot = Robot(vX: vX, vY: vY, x: x, y: y)
            robots.append(robot)
        }

        return robots
    }
}
