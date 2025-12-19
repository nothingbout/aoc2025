// The Swift Programming Language
// https://docs.swift.org/swift-book

@main
struct AOC {
    static func readFile(_ path: String, createIfNotFound: Bool = false) -> String {
        guard let input = try? String(contentsOfFile: path, encoding: .utf8) else {
            if createIfNotFound {
                try? "".write(toFile: path, atomically: true, encoding: .utf8)
            }
            fatalError("Failed to read input file: \(path)")
        }
        return input
    }

    static func pathForDay(dayClass: AnyClass, suffix: String) -> String {
        return "Data/AOC2025/\(String(describing: dayClass).lowercased())_\(suffix).txt"
    }

    static func main() {
        let dayClass = Day05.self
        let input = readFile(pathForDay(dayClass: dayClass, suffix: "input"), createIfNotFound: true)

        let lines = input.replacingOccurrences(of: "\r", with: "").split(omittingEmptySubsequences: false){ $0.isNewline }.map { String($0) }
        let (part1, part2) = dayClass.run(lines: lines)
        print("Part 1: \(part1)")
        print("Part 2: \(part2)")
    }
}
