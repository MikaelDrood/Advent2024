import Algorithms

class Day08: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String

    var m: [[String]]
    //var m2: [[String]]
    var antidotes: Set<[Int]> = []
    let rC: Int
    let cC: Int

    required init(data: String) {
        self.data = data

        m = Self.parse(data)
        //m2 = m
        rC = m.count
        cC = m[0].count
    }

    func part1() -> Any {
        solve(useHarmonics: false)
    }

    func part2() -> Any {
        solve(useHarmonics: true)
    }
}

private extension Day08 {

    static func parse(_ data: String) -> [[String]] {
        let rows = data.components(separatedBy: "\n")
        return rows.map { row in row.map { String($0) } }
    }

    func solve(useHarmonics: Bool) -> Int {
        var stsMap: [String: [[Int]]] = [:]

        for r in 0 ..< rC {
            for c in 0 ..< cC {
                let st = m[r][c]
                if st != "." {
                    stsMap[st, default: []].append([r, c])
                }
            }
        }

        for (_, sts) in stsMap {
            guard sts.count >= 2 else { continue }

            let stsSet = Set(sts)

            for i in 0 ..< sts.count {
                let st1 = sts[i]

                for j in i + 1 ..< sts.count {
                    let st2 = sts[j]
                    let rD = st2[0] - st1[0]
                    let cD = st2[1] - st1[1]

                    var r = st1[0], c = st1[1]

                    while isValid(r - rD, c - cD) {
                        r -= rD
                        c -= cD
                    }

                    var count = 0

                    while isValid(r, c) {
                        if stsSet.contains([r, c]) {
                            count += 1
                        }
                        r += rD
                        c += cD
                    }

                    if count == 2 {
                        markAntidote(st1, st2, rD, cD, useHarmonics)
                    }
                }
            }
        }

//        for r in m2 {
//            print(r.joined())
//        }

        return antidotes.count
    }

    func markAntidote(_ st1: [Int], _ st2: [Int], _ rD: Int, _ cD: Int, _ useResHarmonics: Bool) {
        if useResHarmonics {
            antidotes.insert([st1[0], st1[1]])
            //m2[st1[0]][st1[1]] = "#"
            antidotes.insert([st2[0], st2[1]])
            //m2[st2[0]][st2[1]] = "#"
        }

        var rA = st1[0] - rD
        var cA = st1[1] - cD

        while isValid(rA, cA) {
            antidotes.insert([rA, cA])
            //m2[rA][cA] = "#"
            rA -= rD
            cA -= cD

            if !useResHarmonics {
                break
            }
        }

        rA = st2[0] + rD
        cA = st2[1] + cD

        while isValid(rA, cA) {
            antidotes.insert([rA, cA])
            //m2[rA][cA] = "#"
            rA += rD
            cA += cD

            if !useResHarmonics {
                break
            }
        }
    }

    func isValid(_ r: Int, _ c: Int) -> Bool {
        return r >= 0 && r < rC && c >= 0 && c < cC
    }
}
