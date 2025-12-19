import Foundation

public class Day04 {
    struct Vector2: Equatable, Hashable {
        var x: Int
        var y: Int

        init(_ x: Int, _ y: Int) {
            self.x = x
            self.y = y
        }

        static func + (a: Vector2, b: Vector2) -> Vector2 {
            return .init(a.x + b.x, a.y + b.y)
        }
    }

    enum CellType {
        case roll
    }

    static let offsets8: [Vector2] = [
        .init(1, 0),
        .init(1, 1),
        .init(0, 1),
        .init(-1, 1),
        .init(-1, 0),
        .init(-1, -1),
        .init(0, -1),
        .init(1, -1),
    ]
    
    public static func run(lines: [String]) -> (Int, Int) {
        var part1: Int = 0
        var part2: Int = 0

        var map: Dictionary<Vector2, CellType> = [:]
        var mapSize = Vector2(0, 0)
        for (y, line) in lines.enumerated() {
            mapSize.y = y + 1
            for (x, char) in line.enumerated() {
                mapSize.x = max(mapSize.x, x + 1)
                if char != "." {
                    map[Vector2(x, y)] = switch char {
                        case "@": .roll
                        case _: fatalError("Unknown cell type: \(char)")
                    }
                }
            }
        }

        func countNeighborRolls(_ cellPos: Vector2, map: Dictionary<Vector2, CellType>) -> Int {
            var neighborRolls = 0
            for offset in offsets8 {
                if map[cellPos + offset] == .roll {
                    neighborRolls += 1
                }
            }
            return neighborRolls
        }

        do { // part1
            for cellPos in map.keys {
                if map[cellPos] == .roll && countNeighborRolls(cellPos, map: map) < 4 {
                    part1 += 1
                }
            }
        }

        do { // part2
            func tryRemoveRolls(pos: Vector2, map: inout Dictionary<Vector2, CellType>) -> Int {
                if map[pos] != .roll || countNeighborRolls(pos, map: map) >= 4 {
                    return 0
                }
                var removed = 1
                map[pos] = nil
                for offset in offsets8 {
                    removed += tryRemoveRolls(pos: pos + offset, map: &map)
                }
                return removed
            }

        
            var mutableMap = map
            for cellPos in map.keys {
                part2 += tryRemoveRolls(pos: cellPos, map: &mutableMap)
            }
        }

        return (part1, part2)
    }
}
