// The Swift Programming Language
// https://docs.swift.org/swift-book

@main
struct AOC {
    static func main() {
        let inputFilePath = "Data/AOC2025/day02_input.txt"
        guard let input = try? String(contentsOfFile: inputFilePath, encoding: .utf8) else {
            fatalError("Failed to read input file: \(inputFilePath)")
        }
        let lines = input.replacingOccurrences(of: "\r", with: "").split{ $0.isNewline }.map { String($0) }
        let (part1, part2) = Day02.run(lines: lines)
        print("Part 1: \(part1)")
        print("Part 2: \(part2)")
    }
}
