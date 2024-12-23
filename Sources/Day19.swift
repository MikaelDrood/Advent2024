import Algorithms

struct Day19: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String

    func part1() -> Any {
        let (patterns, designs) = parseData()

        return designs.reduce(into: 0) { res, design in
            var prefixes: Set<String> = Set(patterns.filter { design.hasPrefix($0) })

            while !prefixes.isEmpty {
                let prefix = prefixes.removeFirst()

                for pattern in patterns {
                    let newPrefix = prefix + pattern

                    guard newPrefix != design else {
                        res += 1
                        return
                    }

                    if design.hasPrefix(newPrefix) {
                        prefixes.insert(newPrefix)
                    }
                }
            }
        }
    }

    func part2() -> Any {
        let (patterns, designs) = parseData()

        func search(_ design: String) -> Int {
            var memo: [String: Int] = [:]

            func dp(_ target: String) -> Int {
                guard !target.isEmpty else { return 1 }

                if let m = memo[target] {
                    return m
                }

                var count = 0
                for pattern in patterns where target.hasPrefix(pattern) {
                    count += dp(String(target.trimmingPrefix(pattern)))
                }
                memo[target, default: 0] += count

                return memo[target, default: 0]
            }

            return dp(design)
        }

        return designs.reduce(into: 0) { res, design in
            res += search(design)
        }
    }
}

private extension Day19 {
    func parseData() -> ([String], [String]) {
        let components = data.components(separatedBy: .newlines).filter { !$0.isEmpty }
        let patterns = components[0].components(separatedBy: ", ")
        let designs = Array(components[1...])

        return (patterns, designs)
    }
}
