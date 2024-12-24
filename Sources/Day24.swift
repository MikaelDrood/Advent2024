import Algorithms

struct Day24: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String

    struct Input {
        struct Task {
            enum Operation: String {
                case or = "OR"
                case xor = "XOR"
                case and = "AND"

                func applyLogic(_ val1: Int, _ val2: Int) -> Int {
                    return switch self {
                    case .or: val1 | val2
                    case .xor: val1 ^ val2
                    case .and: val1 & val2
                    }
                }
            }

            let val1: String
            let val2: String
            let op: Operation
            let output: String
        }

        let vals: [String: Int]
        let tasks: [Task]
    }

    func part1() -> Any {
        let input = parseData()

        var vals = input.vals
        var tasks = input.tasks

        while !tasks.isEmpty {
            for i in (0 ..< tasks.count).reversed() {
                let t = tasks[i]

                guard let val1 = vals[t.val1],
                      let val2 = vals[t.val2]
                else { continue }

                vals[t.output] = t.op.applyLogic(val1, val2)
                tasks.remove(at: i)
            }
        }

        var output = 0
        var mul = 1

        for (_, val) in vals.filter({ $0.key.first == "z" }).sorted(by: { $0.key < $1.key}) {
            output += val * mul
            mul *= 2
        }

        return output
    }

    func part2() -> Any {
        return 0
    }
}

private extension Day24 {
    func parseData() -> Input {
        var vals: [String: Int] = [:]
        var tasks: [Input.Task] = []

        for component in data.components(separatedBy: "\n") {
            if component.contains(": ") {
                let val = component.components(separatedBy: ": ")
                vals[val[0]] = Int(val[1])!
            }

            if component.contains(" -> ") {
                let task = component.components(separatedBy: " ")
                tasks.append(
                    Input.Task(
                        val1: task[0],
                        val2: task[2],
                        op: Input.Task.Operation(rawValue: task[1])!,
                        output: task[4]
                    )
                )
            }
        }

        return Input(vals: vals, tasks: tasks)
    }
}
