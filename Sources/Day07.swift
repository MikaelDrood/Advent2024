import Algorithms

struct Day07: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String

    func part1() -> Any {
        let m = parseData()
        var sum = 0

        for (k, v) in m {
            var calc: [Int] = [v[0]]

            for n in v[1...] {
                var i = 0
                let c = calc.count

                while i < c {
                    let r = calc.removeFirst()
                    calc.append(r * n)
                    calc.append(r + n)
                    i += 1
                }
            }

            sum += calc.contains(k) ? k : 0
        }

        return sum
    }

    func part2() -> Any {
        let m = parseData()
        var sum = 0

        for (k, v) in m {
            var calc: Deque = [v[0]]

            for n in v[1...] {
                var i = 0
                let c = calc.count

                while i < c {
                    let r = calc.removeFirst()
                    calc.append(r * n)
                    calc.append(r + n)

                    var nn = n
                    var mut = 1
                    while nn > 0 {
                        nn /= 10
                        mut *= 10
                    }

                    calc.append(r * mut + n)

                    i += 1
                }
            }

            sum += calc.contains(k) ? k : 0
        }

        return sum
    }

    private func parseData() -> [Int: [Int]] {
        let rows = data.components(separatedBy: "\n")

        return rows.reduce(into: [:]) { res, row in
            var ar = row.components(separatedBy: [":", " "]).compactMap { Int($0) }
            res[ar.removeFirst()] = ar
        }
    }
}
