import Algorithms

struct Day22: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String
    let modulo = 16777216

    func part1() -> Any {
        let numbers = parseData()
        let secrects = numbers.map(get2000Number(_:))
        return secrects.reduce(0, +)
    }

    func part2() -> Any {
        var numbers = parseData()
        var prices = numbers.map { $0 % 10 }

        var changes: [[Int]] = []
        var banned: Set<String> = []

        var bananas: [String: Int] = [:]

        func add(_ change: [Int]) {
            changes.append(change)

            if changes.count == 5 {
                changes.removeFirst()
            }

            analyse()
        }

        func analyse() {
            guard changes.count == 4 else { return }

            for i in 0 ..< changes[0].count {
                let k = "\(changes[0][i]),\(changes[1][i]),\(changes[2][i]),\(changes[3][i])"
                let kBan = "\(i) \(k)"

                guard !banned.contains(kBan) else { continue }

                banned.insert(kBan)
                bananas[k, default: 0] += prices[i]
            }
        }

        for _ in 0 ..< 2000 {
            numbers = getNextNumbers(numbers)
            let nextPrices = numbers.map { $0 % 10 }

            let changes = zip(nextPrices, prices).map { $0.0 - $0.1 }
            prices = nextPrices

            add(changes)
        }

        return bananas.values.max()!
    }
}

private extension Day22 {
    func parseData() -> [Int] {
        return data.components(separatedBy: "\n").map { Int($0)! }
    }

    func get2000Number(_ n: Int) -> Int {
        var n = n
        for _ in 0 ..< 2000 {
            n = ((n * 64) ^ n) % modulo
            n = ((n / 32) ^ n) % modulo
            n = ((n * 2048) ^ n) % modulo
        }

        return n
    }

    func getNextNumbers(_ nums: [Int]) -> [Int] {
        return nums.map { n in
            var n = ((n * 64) ^ n) % modulo
            n = ((n / 32) ^ n) % modulo
            n = ((n * 2048) ^ n) % modulo

            return n
        }
    }
}
