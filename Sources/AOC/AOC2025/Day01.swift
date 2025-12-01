import Foundation

public class Day01 {
    public static func run(lines: [String]) -> (Int, Int) {
        var position = 50
        var part1 = 0
        var part2 = 0
        for line in lines {
            let direction = line.prefix(1)
            let steps = Int(line.suffix(from: line.index(line.startIndex, offsetBy: 1)))!

            for _ in 0..<steps {
                if direction == "L" {
                    position -= 1
                    if position < 0 {
                        position = 99
                    }
                }
                else {
                    position += 1
                    if position > 99 {
                        position = 0
                    }
                }

                if position == 0 {
                    part2 += 1
                }
            }

            if position == 0 {
                part1 += 1
            }
        }
        return (part1, part2)
    }
}
