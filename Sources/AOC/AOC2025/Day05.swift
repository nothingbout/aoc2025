import Foundation

public class Day05 {
    struct Range: Equatable, Hashable {
        var min: Int
        var max: Int
        var count: Int { max - min + 1}
    }

    public static func run(lines: [String]) -> (Int, Int) {
        var part1: Int = 0
        var part2: Int = 0

        var parsingRanges = true
        var ranges: [Range] = []

        for line in lines {
            if line.isEmpty {
                parsingRanges = false
                continue
            }

            if parsingRanges {
                let values = line.split(separator: "-").map { Int($0)! }
                ranges.append(Range(min: values[0], max: values[1]))
            }
            else {
                let id = Int(line)!
                for range in ranges {
                    if id >= range.min && id <= range.max {
                        part1 += 1
                        break
                    }
                }
            }
        }

        ranges.sort { $0.min < $1.min }
        var currentRange = ranges[0]
        for range in ranges[1...] {
            if range.min > currentRange.max {
                part2 += currentRange.count
                currentRange = range
            }
            else {
                currentRange.max = max(currentRange.max, range.max)
            }
        }
        part2 += currentRange.count

        return (part1, part2)
    }
}
