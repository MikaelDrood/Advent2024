import Algorithms

struct Day09: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String

    func part1() -> Any {
        var blocks = fetchBlocks()

        var i = blocks.firstIndex(of: -1)!
        var j = blocks.lastIndex(where: { $0 != -1 })!

        while i < j {
            if blocks[i] == -1, blocks[j] != -1 {
                blocks.swapAt(i, j)
                i += 1
                j -= 1
            } else if blocks[i] != -1 {
                i += 1
            } else {
                j -= 1
            }
        }

        return blocks.enumerated().reduce(into: 0) { res, p in
            res += p.1 == -1 ? 0 : p.0 * p.1
        }
    }

    func part2() -> Any {
        var blocks = fetchBlocks()

        func move(_ value: Int, _ size: Int, from j: Int) {
            guard value != -1 else { return }

            var freeSize = 0
            var i = 0

            while i < blocks.count, i < j {
                if blocks[i] == -1 {
                    freeSize += 1

                    if freeSize == size {
                        break
                    }
                } else {
                    freeSize = 0
                }

                i += 1
            }

            guard freeSize == size else { return }

            i -= size - 1

            for k in i ..< i + size {
                blocks[k] = value
            }

            for k in j ..< j + size {
                blocks[k] = -1
            }
        }

        var mov = blocks.last(where: { $0 != -1 })!
        var j = blocks.lastIndex(of: mov)!
        var movSize = 0

        while j >= 0 {
            if blocks[j] == mov {
                movSize += 1
                j -= 1
            } else {
                move(mov, movSize, from: j + 1)
                mov = blocks[j]
                movSize = 0
            }
        }

        return blocks.enumerated().reduce(into: 0) { res, p in
            res += p.1 == -1 ? 0 : p.0 * p.1
        }
    }
}

private extension Day09 {
    func fetchBlocks() -> [Int] {
        let input = data.map { $0.wholeNumberValue! }
        var freeDecrement = 0

        return input.enumerated().reduce(into: []) { res, p in
            let isData = p.0 % 2 == 0

            for _ in 0 ..< p.1 {
                res.append(isData ? p.0 - freeDecrement: -1)
            }

            freeDecrement += isData ? 0 : 1
        }
    }
}
