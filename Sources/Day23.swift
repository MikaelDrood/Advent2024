import Algorithms

struct Day23: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String

    func part1() -> Any {
        let pairs = parseData()
        var triplets: [[String]] = []

        for (first, connected) in pairs {
            for second in connected {
                for third in pairs[second, default: []] {
                    if pairs[third]?.contains(first) == true {
                        triplets.append([first, second, third])
                    }
                }
            }
        }

        let tripletsSet = Set(triplets.map { $0.sorted() })

        return tripletsSet.filter { $0.contains(where: { $0.first == "t" })}.count
    }

    func part2() -> Any {
        return 0
    }
}

private extension Day23 {
    func parseData() -> [String: [String]] {
        var map: [String: [String]] = [:]

        for pair in data.components(separatedBy: "\n") {
            let comps = pair.components(separatedBy: "-")
            map[comps[0], default: []].append(comps[1])
            map[comps[1], default: []].append(comps[0])
        }

        return map
    }
}
