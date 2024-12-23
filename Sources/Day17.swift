import Algorithms
import RegexBuilder
import Foundation

struct Day17: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String

    class Computer {
        enum Opcode: Int {
            case adv = 0 // A / 2^operand
            case bxl = 1 // B xor operand
            case bst = 2 // b = operand % 8
            case jnz = 3 // A == 0 ? nothing : jump to operand ptr
            case bxc = 4 // B xor C -> B
            case out = 5 // output =out operand % 8
            case bdv = 6 // A / 2^operand -> B
            case cdv = 7 // A / 2^operand -> C
        }

        var a: Int
        var b: Int
        var c: Int
        let program: [Int]

        init(a: Int, b: Int, c: Int, program: [Int]) {
            self.a = a
            self.b = b
            self.c = c
            self.program = program
        }

        func operand(_ op: Int) -> Int {
            switch op {
            case 0, 1, 2, 3: return op
            case 4: return a
            case 5: return b
            case 6: return c
            default: return -1
            }
        }

        func execute() -> [Int] {
            var output: [Int] = []
            var ptr = 0

            while ptr < program.count {
                let op = Opcode(rawValue: program[ptr])!

                let val = program[ptr + 1]
                let combo = operand(val)

                var nextPtr = ptr + 2
                switch op {
                case .adv: a = a / Int(pow(2, Double(combo)))
                case .bxl: b = b ^ val
                case .bst: b = combo % 8
                case .jnz:
                    if a != 0 {
                        nextPtr = val
                    }
                case .bxc: b = b ^ c
                case .out: output.append(combo % 8)
                case .bdv: b = a / Int(pow(2, Double(combo)))
                case .cdv: c = a / Int(pow(2, Double(combo)))
                }

                ptr = nextPtr
            }
            return output
        }
    }

    func part1() -> Any {
        let pc = parseData()
        let output = pc.execute()

        return output.map { "\($0)" }.joined(separator: ",")
    }

    func part2() -> Any {
        let pc = parseData()
        var output: [Int] = []
        var a = 0

        while output != pc.program {
            pc.a = a
            output = pc.execute()
            a += 1
        }

        return a - 1
    }
}

private extension Day17 {
    func parseData() -> Computer {
        let regex = Regex {
            "Register A: "
            Capture { OneOrMore(.digit) }
            "\n"
            "Register B: "
            Capture { OneOrMore(.digit) }
            "\n"
            "Register C: "
            Capture { OneOrMore(.digit) }
            "\n\n"
            "Program: "
            Capture {
                OneOrMore(.digit)
                ZeroOrMore {
                    ","
                    OneOrMore(.digit)
                }
            }
        }

        var pc: Computer?

        for match in data.matches(of: regex) {
            let a = Int(match.1)!
            let b = Int(match.2)!
            let c = Int(match.3)!
            let program = String(match.4).components(separatedBy: ",").compactMap { Int($0) }

            pc = Computer(a: a, b: b, c: c, program: program)
        }

        return pc!
    }
}
