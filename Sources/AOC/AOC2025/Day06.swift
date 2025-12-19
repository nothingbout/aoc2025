import Foundation

public class Day06 {
    static func add(a: Int, b: Int) -> Int { a + b }
    static func mul(a: Int, b: Int) -> Int { a * b }

    public static func run(lines: [String]) -> (Int, Int) {
        var part1 = 0
        var part2 = 0

        do { // part1
            var lists: [[Int]] = []
            for (lineIndex, line) in lines.enumerated() {
                let cols = line.split(separator: " ", omittingEmptySubsequences: true)
                if lineIndex < lines.count - 1 {
                    for (colIndex, col) in cols.enumerated() {
                        if colIndex >= lists.count {
                            lists.append([])
                        }
                        lists[colIndex].append(Int(col)!)
                    }
                }
                else {
                    for (colIndex, col) in cols.enumerated() {
                        let (startValue, op) = switch col {
                            case "+": (0, add)
                            case "*": (1, mul)
                            default: fatalError("Unknown operator: \(col)")
                        }
                        part1 += lists[colIndex].reduce(startValue, op)
                    }
                }
            }
        }

        do { // part2
            var divideCols: [Int] = [-1]
            for i in 0..<lines[0].count {
                var allSpaces = true
                for line in lines {
                    if line.characterAt(i) != " " {
                        allSpaces = false
                        break
                    }
                }
                if allSpaces {
                    divideCols.append(i)
                }
            }
            divideCols.append(lines[0].count)

            for col in 0..<divideCols.count - 1 {
                let start = divideCols[col] + 1
                let length = divideCols[col + 1] - start

                var nums = [Int](repeating: 0, count: length)
                for i in 0..<length {
                    for line in lines[0..<lines.count - 1] {
                        let char = line.characterAt(start + i)
                        if char != " " {
                            let digit = Int(char.asciiValue! - UInt8(ascii: "0"))
                            nums[i] = nums[i] * 10 + digit
                        }
                    }
                }

                let (startValue, op) = switch lines[lines.count - 1].characterAt(start) {
                    case "+": (0, add)
                    case "*": (1, mul)
                    default: fatalError("Unknown operator: \(col)")
                }                
                part2 += nums.reduce(startValue, op)
            }
        }

        return (part1, part2)
    }
}
