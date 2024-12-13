import Algorithms
import RegexBuilder

struct Machine {
    struct Button {
        let price: Int
        let x: Int
        let y: Int
    }

    struct Prize {
        let x: Int
        let y: Int
    }

    let a: Button
    let b: Button

    let prize: Prize
}

struct Day13: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String

    func part1() -> Any {
        let machines = parseData()

        func play(_ machine: Machine) -> Int {
            let px = machine.prize.x, py = machine.prize.y
            var memo: [String: Int] = [:]

            func turn(_ x: Int, _ y: Int, _ cost: Int, _ at: Int, _ bt: Int) -> Int {
                let k = "\(x) \(y)"

                if let m = memo[k] {
                    return m
                }

                guard at <= 100, bt <= 100 else { return -1 }

                if x == px, y == py {
                    return cost
                }
                guard x <= px, y <= py else { return -1 }

                let ans1 = turn(x + machine.a.x, y + machine.a.y, cost + machine.a.price, at + 1, bt)
                let ans2 = turn(x + machine.b.x, y + machine.b.y, cost + machine.b.price, at, bt + 1)

                let ans = ans1 == -1 ? ans2 : (ans2 == -1 ? ans1 : min(ans1, ans2))
                memo[k] = ans

                return ans
            }

            return turn(0, 0, 0, 0, 0)
        }

        return machines.reduce(into: 0) { sum, machine in
            let cost = play(machine)
            sum += cost == -1 ? 0 : cost
        }
    }

    func part2() -> Any {
        return 0
    }
}

private extension Day13 {
    func parseData(_ priceIncement: Int = 0) -> [Machine] {
        let regex = Regex {
            "Button A: X+"
            Capture { OneOrMore(.digit) }
            ", Y+"
            Capture { OneOrMore(.digit) }
            "\nButton B: X+"
            Capture { OneOrMore(.digit) }
            ", Y+"
            Capture { OneOrMore(.digit) }
            "\nPrize: X="
            Capture { OneOrMore(.digit) }
            ", Y="
            Capture { OneOrMore(.digit) }
            ZeroOrMore { .whitespace }
        }

        var machines: [Machine] = []

        for match in data.matches(of: regex) {
            let a = Machine.Button(price: 3, x: Int(match.1)!, y: Int(match.2)!)
            let b = Machine.Button(price: 1, x: Int(match.3)!, y: Int(match.4)!)
            let prize = Machine.Prize(x: Int(match.5)!, y: Int(match.6)!)

            machines.append(Machine(a: a, b: b, prize: prize))
        }

        return machines
    }
}
