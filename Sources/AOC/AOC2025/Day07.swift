import Foundation

public class Day07 {
    public static func run(lines: [String]) -> (Int, Int) {
        var part1: Int = 0
        var part2: Int = 0

        var beams: Dictionary<Int, Int> = [:]

        for (lineIndex, line) in lines.enumerated() {
            if lineIndex == 0 {
                for (x, char) in line.enumerated() {
                    if char == "S" {
                        beams[x] = 1
                        break
                    }
                }
            }
            else {
                for (x, char) in line.enumerated() {
                    if char == "^" {
                        if let count = beams[x] {
                            part1 += 1
                            beams.removeValue(forKey: x)
                            beams[x - 1] = (beams[x - 1] ?? 0) + count
                            beams[x + 1] = (beams[x + 1] ?? 0) + count
                        }
                    }
                }
            }
        }

        part2 = beams.values.reduce(0, +)
        return (part1, part2)
    }
}
