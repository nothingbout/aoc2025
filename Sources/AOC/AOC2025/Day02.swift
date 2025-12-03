import Foundation

public class Day02 {
    public static func run(lines: [String]) -> (Int, Int) {
        var part1Values = Set<Int>()
        var part2Values = Set<Int>()

        for line in lines {
            let ranges = line.split(separator: ",")
            for range in ranges {
                let rangeValues = range.split(separator: "-").map { Int($0)! }
                let (min, max) = (rangeValues[0], rangeValues[1])

                for value in min...max {
                    let valueString = String(value)

                    if valueString.count % 2 == 0 {
                        let firstHalf = valueString.prefix(valueString.count / 2)
                        let secondHalf = valueString.suffix(valueString.count / 2)
                        if firstHalf == secondHalf {
                            part1Values.insert(value)
                        }
                    }

                    if valueString.count >= 2 {
                        for splitCount in 2...valueString.count {
                            if valueString.count % splitCount != 0 {
                                continue
                            }
                            let charsPerPart = valueString.count / splitCount
                            let firstPart = valueString.prefix(charsPerPart)
                            var allPartsEqual = true
                            for i in 1..<splitCount {
                                let part = valueString.substring(i * charsPerPart..<(i + 1) * charsPerPart)
                                if part != firstPart {
                                    allPartsEqual = false
                                    break
                                }
                            }
                            if allPartsEqual {
                                part2Values.insert(value)
                            }
                        }
                    }
                }
            }
        }

        let part1 = part1Values.reduce(0, +)
        let part2 = part2Values.reduce(0, +)
        return (part1, part2)
    }
}
