import Foundation

public class Day09 {
    struct Vector2: Equatable, Hashable, CustomStringConvertible {
        var x, y: Int
        init(_ x: Int, _ y: Int) { self.x = x; self.y = y }
        static func + (a: Vector2, b: Vector2) -> Vector2 { .init(a.x + b.x, a.y + b.y) }
        static func - (a: Vector2, b: Vector2) -> Vector2 { .init(a.x - b.x, a.y - b.y) }
        static func min(a: Vector2, b: Vector2) -> Vector2 { .init(Swift.min(a.x, b.x), Swift.min(a.y, b.y)) }
        static func max(a: Vector2, b: Vector2) -> Vector2 { .init(Swift.max(a.x, b.x), Swift.max(a.y, b.y)) }
        var description: String { "(\(x), \(y))" }
    }

    public static func run(lines: [String]) -> (Int, Int) {
        var part1: Int = 0
        var part2: Int = 0

        var redTiles: [Vector2] = []
        for line in lines {
            let values = line.split(separator: ",").map { Int($0)! }
            redTiles.append(Vector2(values[0], values[1]))
        }

        do { // part1
            for i in 0..<redTiles.count {
                for j in i+1..<redTiles.count {
                    let (p1, p2) = (redTiles[i], redTiles[j])
                    let area = (abs(p1.x - p2.x) + 1) * (abs(p1.y - p2.y) + 1)
                    part1 = max(part1, area)
                }
            }
        }

        do { // part2
            var outsideCorners: [Vector2] = []
            for i in 0..<redTiles.count {
                let p0 = redTiles[i]
                let p1 = redTiles[(i + 1) % redTiles.count]
                let p2 = redTiles[(i + 2) % redTiles.count]
                if p0.x != p1.x {
                    let direction = p0.x < p1.x ? 1 : -1
                    let nextDirection = p1.y < p2.y ? 1 : -1
                    if direction * nextDirection > 0 {
                        outsideCorners.append(Vector2(p1.x + direction, p1.y - direction))
                    }
                    else if direction * nextDirection < 0 {
                        outsideCorners.append(Vector2(p1.x - direction, p1.y - direction))
                    }
                    else {
                        fatalError("unexpected")
                    }
                }
                else if p0.y != p1.y {
                    let direction = p0.y < p1.y ? 1 : -1
                    let nextDirection = p1.x < p2.x ? 1 : -1
                    if direction * nextDirection > 0 {
                        outsideCorners.append(Vector2(p1.x + direction, p1.y - direction))
                    }
                    else if direction * nextDirection < 0 {
                        outsideCorners.append(Vector2(p1.x + direction, p1.y + direction))
                    }
                    else {
                        fatalError("unexpected")
                    }
                }
                else {
                    fatalError("unexpected")
                }
            }

            func lineIntersectsRect(p1: Vector2, p2: Vector2, rectMin: Vector2, rectMax: Vector2) -> Bool {
                if max(p1.x, p2.x) < rectMin.x || min(p1.x, p2.x) > rectMax.x || max(p1.y, p2.y) < rectMin.y || min(p1.y, p2.y) > rectMax.y {
                    return false
                }
                return true
            }

            for i in 0..<redTiles.count {
                for j in i+1..<redTiles.count {
                    let (red1, red2) = (redTiles[i], redTiles[j])
                    let (rectMin, rectMax) = (Vector2.min(a: red1, b: red2), Vector2.max(a: red1, b: red2))

                    let area = (rectMax.x - rectMin.x + 1) * (rectMax.y - rectMin.y + 1)
                    if area > part2 {
                        var intersectsOutside = false
                        for k in 0..<outsideCorners.count {
                            let c1 = outsideCorners[k]
                            let c2 = outsideCorners[(k + 1) % outsideCorners.count]
                            if lineIntersectsRect(p1: c1, p2: c2, rectMin: rectMin, rectMax: rectMax) {
                                intersectsOutside = true
                                break
                            }
                        }
                        if !intersectsOutside {
                            part2 = area
                        }
                    }
                }
            }
        }
       
        return (part1, part2)
    }
}
