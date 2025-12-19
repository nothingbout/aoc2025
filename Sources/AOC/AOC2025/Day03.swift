import Foundation

public class Day03 {
    public static func run(lines: [String]) -> (Int, Int) {
        var part1: Int = 0
        var part2: Int = 0
        for line in lines {
            let bank: [Int] = line.utf8.map { Int($0 - UInt8(ascii: "0")) }
            do { // part1
                var maxJolts = 0
                for i in 0..<bank.count {
                    for j in i+1..<bank.count {
                        let jolts = bank[i] * 10 + bank[j]
                        if jolts > maxJolts {
                            maxJolts = jolts
                        }
                    }
                }
                part1 += maxJolts
            }
            do { // part2
                let maxBatteries = 12
                var totalJolts = 0
                var currentBattery = 0
                for batteries in 0..<maxBatteries {
                    var maxBatteryJolt = 0
                    var maxBatteryIndex = 0
                    for i in currentBattery...(bank.count - (maxBatteries - batteries)) {
                        if bank[i] > maxBatteryJolt {
                            maxBatteryJolt = bank[i]
                            maxBatteryIndex = i
                        }
                    }

                    totalJolts = totalJolts * 10 + maxBatteryJolt
                    currentBattery = maxBatteryIndex + 1
                }
                part2 += totalJolts
            }
        }
        return (part1, part2)
    }
}
