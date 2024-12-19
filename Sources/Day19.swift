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

        return designs.reduce(into: 0) { res, design in
            var prefixes: [String] = patterns.filter { design.hasPrefix($0) }
            var prefixMap: [String: Int] = prefixes.reduce(into: [:]) { res, p in
                res[p] = 1
            }

            while !prefixes.isEmpty {
                let prefix = prefixes.removeFirst()
                let count = prefixMap[prefix, default: 1]

                for pattern in patterns {
                    let newPrefix = prefix + pattern

                    if design.hasPrefix(newPrefix) {
                        if prefixMap[newPrefix] == nil {
                            prefixes.append(newPrefix)
                        }

                        prefixMap[newPrefix, default: 0] += count
                    }
                }
            }

            res += prefixMap[design, default: 0]
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
