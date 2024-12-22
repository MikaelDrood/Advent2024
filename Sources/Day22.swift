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

        var change1: [Int] = []
        var change2: [Int] = []
        var change3: [Int] = []
        var change4: [Int] = []

        func add(_ changes: [Int]) {
            if change1.isEmpty {
                change1 = changes
            } else if change2.isEmpty {
                change2 = changes
            } else if change3.isEmpty {
                change3 = changes
            } else if change4.isEmpty {
                change4 = changes
            } else {
                change1 = change2
                change2 = change3
                change3 = change4
                change4 = changes
            }

            analyse()
        }

        var b: [String: Int] = [:]
        var banned: Set<String> = []

        func analyse() {
            guard !change4.isEmpty else { return }

            for i in 0 ..< change1.count {
                let k = "\(change1[i]),\(change2[i]),\(change3[i]),\(change4[i])"
                let kBan = "\(i) \(k)"

                guard !banned.contains(kBan) else { continue }

                banned.insert(kBan)
                b[k, default: 0] += prices[i]

                if k == "-2,1,-1,3" {

                }
            }
        }

        for _ in 0 ..< 2000 {
            numbers = getNextNumbers(numbers)
            let nextPrices = numbers.map { $0 % 10 }

            let changes = zip(nextPrices, prices).map { $0.0 - $0.1 }
            prices = nextPrices

            add(changes)
        }

        return b.values.max()!
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
