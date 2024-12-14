import Algorithms
import RegexBuilder

struct Day14: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String

    struct Robot {
        let vX: Int
        let vY: Int
        let x: Int
        let y: Int
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

            if x < c / 2, y < r / 2 {
                f1 += 1
            } else if x > c / 2, y < r / 2 {
                f2 += 1
            } else if x < c / 2, y > r / 2 {
                f3 += 1
            } else if x > c / 2, y > r / 2 {
                f4 += 1
            }
        }

        return f1 * f2 * f3 * f4
    }

    func part2() -> Any {
        return 0
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
