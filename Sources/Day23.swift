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
        let pairs = parseData2()
        let nodes = Set(pairs.flatMap { $0 })

        var parties: [[String]] = nodes.map { [$0] }
        var didJoin = true

        while didJoin {
            didJoin = false
            var newParties: [[String]] = []

            for party in parties {
                for node in nodes {
                    if party.allSatisfy({ pairs.contains([$0, node].sorted()) }) {
                        newParties.append((party + [node]).sorted())
                        didJoin = true
                    }
                }
            }

            if didJoin {
                parties = Array(Set(newParties))
            }
        }

        let pass = parties.sorted { $0.count > $1.count }.first?.sorted().joined(separator: ",") ?? ""

        return pass
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

    func parseData2() -> Set<[String]> {
        return data.components(separatedBy: "\n").reduce(into: []) { res, pair in
            let nodes = pair.components(separatedBy: "-").sorted()
            res.insert(nodes)
        }
    }
}
