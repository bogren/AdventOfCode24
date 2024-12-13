import Foundation
import ArgumentParser
import Collections

struct Day11: ParsableCommand {
  private var fileURL = Bundle.module.url(
    forResource: "day11",
    withExtension: nil,
    subdirectory: "Input"
  )!

  mutating func run() throws {
    var stones = try String(contentsOf: fileURL, encoding: .utf8)
      .split(separator: " ").map(String.init).compactMap(Int.init)

    for _ in 0..<25 {
      var newStones: [Int] = []
      for stone in stones {
        if stone == 0 {
          newStones.append(1)
        } else if String(stone).count % 2 == 0 {
          newStones.append(Int(String(stone).prefix(String(stone).count / 2))!)
          newStones.append(Int(String(stone).suffix(String(stone).count / 2))!)
        } else {
          newStones.append(stone * 2024)
        }
      }
      stones = newStones
    }
    print(stones.count)
  }
}
