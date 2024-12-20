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
        var count = 0
        var memo: [String: Int] = [:]

        func search(_ prefix: String, _ design: String) {
            guard design.hasPrefix(prefix) else { return }

            guard design != prefix else {
                count += 1
                return
            }

            patterns.forEach { p in
                search(prefix + p, design)
            }
        }

        designs.forEach { d in
            patterns.forEach { p in
                search(p, d)
            }
        }

        return count
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
