import Algorithms

struct Day11: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String

    func part1() -> Any {
        var stones = parseData()

        for i in 0 ..< 25 {
            print(i)
            var updated: [Int] = []

            for stone in stones {
                if stone == 0 {
                    updated.append(1)
                } else if let (n1, n2) = split(stone) {
                    updated.append(n1)
                    updated.append(n2)
                } else {
                    updated.append(stone * 2024)
                }
            }
            stones = updated
        }

        return stones.count
    }

    func part2() -> Any {
        let stones = parseData()
        var memo: [String: Int] = [:]

        func process(_ n: Int, _ blink: Int) -> Int {
            guard blink > 0 else { return 1 }

            let k = "\(n) \(blink)"
            if let m = memo[k] {
                return m
            }

            var count = 0

            if n == 0 {
                count += process(1, blink - 1)
            } else if let (n1, n2) = split(n) {
                count += process(n1, blink - 1)
                count += process(n2, blink - 1)
            } else {
                count += process(n * 2024, blink - 1)
            }

            memo[k] = count
            return count
        }

        return stones.reduce(into: 0) { $0 += process($1, 75) }
    }
}

private extension Day11 {
    func parseData() -> [Int] {
        data.components(separatedBy: " ").map { Int($0)! }
    }

    func split(_ n: Int) -> (Int, Int)? {
        let s = String(n)
        let l = s.count
        guard l % 2 == 0 else { return nil }
        return (Int(s.prefix(l/2))!, Int(s.suffix(l/2))!)
    }
}
