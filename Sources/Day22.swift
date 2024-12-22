import Algorithms

struct Day22: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String

    func part1() -> Any {
        let numbers = parseData()
        let secrects = numbers.map(get2000Number(_:))
        return secrects.reduce(0, +)
    }

    func part2() -> Any {
        return 0
    }
}

private extension Day22 {
    func parseData() -> [Int] {
        return data.components(separatedBy: "\n").map { Int($0)! }
    }

    func get2000Number(_ n: Int) -> Int {
        let modulo = 16777216
        var n = n
        for _ in 0 ..< 2000 {
            n = ((n * 64) ^ n) % modulo
            n = ((n / 32) ^ n) % modulo
            n = ((n * 2048) ^ n) % modulo
        }

        return Int(n)
    }
}
