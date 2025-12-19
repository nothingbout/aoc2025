import Foundation

public class Day08 {
    struct Vector3 {
        var x: Int
        var y: Int
        var z: Int

        init(_ x: Int, _ y: Int, _ z: Int) {
            self.x = x
            self.y = y
            self.z = z
        }

        static func + (a: Vector3, b: Vector3) -> Vector3 {
            return .init(a.x + b.x, a.y + b.y, a.z + b.z)
        }

        static func - (a: Vector3, b: Vector3) -> Vector3 { 
            return .init(a.x - b.x, a.y - b.y, a.z - b.z)
        }

        func sqrMagnitude() -> Int {
            return x * x + y * y + z * z
        }
    }

    public static func run(lines: [String]) -> (Int, Int) {
        var part1: Int = 0
        var part2: Int = 0

        var boxPositions: [Vector3] = []

        for line in lines {
            let values = line.split(separator: ",").map { Int($0)! }
            boxPositions.append(Vector3(values[0], values[1], values[2]))
        }

        var possibleConnections: [(src: Int, dst: Int, sqrDistance: Int)] = []
        for i in 0..<boxPositions.count {
            for j in i+1..<boxPositions.count {
                possibleConnections.append((i, j, (boxPositions[i] - boxPositions[j]).sqrMagnitude()))
            }
        }
        possibleConnections.sort { (a, b) -> Bool in
            return a.sqrDistance < b.sqrDistance
        }

        do { // part1
            var connections: Dictionary<Int, [Int]> = [:]
            let connectionsCount = lines.count == 20 ? 10 : 1000
            for i in 0..<connectionsCount {
                let (src, dst, _) = possibleConnections[i]
                connections[src] = (connections[src] ?? []) + [dst]
                connections[dst] = (connections[dst] ?? []) + [src]
            }

            var boxVisited = [Bool](repeating: false, count: boxPositions.count)
            func countCircuitSize(boxIndex: Int) -> Int {
                if boxVisited[boxIndex] { return 0 }
                boxVisited[boxIndex] = true
                var size = 1
                if let dsts = connections[boxIndex] {
                    for dst in dsts {
                        size += countCircuitSize(boxIndex: dst)
                    }
                }
                return size
            }

            var sizes: [Int] = []
            for i in 0..<boxPositions.count {
                if !boxVisited[i] {
                    let size = countCircuitSize(boxIndex: i)
                    sizes.append(size)
                }
            }
            sizes.sort { $0 > $1 }
            part1 = sizes[0] * sizes[1] * sizes[2]
        }

        do { // part2
            var distinctCircuits: Int = 0
            var boxCircuit: [Int] = []
            for i in 0..<boxPositions.count { 
                distinctCircuits += 1
                boxCircuit.append(i)
            }

            for i in 0..<possibleConnections.count {
                let (src, dst, _) = possibleConnections[i]
                let srcCircuit = boxCircuit[src]
                let dstCircuit = boxCircuit[dst]
                if srcCircuit == dstCircuit {
                    continue
                }
                for j in 0..<boxCircuit.count {
                    if boxCircuit[j] == dstCircuit {
                        boxCircuit[j] = srcCircuit
                    }
                }
                distinctCircuits -= 1
                if distinctCircuits == 1 {
                    part2 = boxPositions[src].x * boxPositions[dst].x
                    break
                }
            }
        }

        return (part1, part2)
    }
}
