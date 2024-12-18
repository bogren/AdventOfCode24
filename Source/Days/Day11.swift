import Foundation
import ArgumentParser

struct Day11: ParsableCommand {
  private var fileURL = Bundle.module.url(
    forResource: "day11",
    withExtension: nil,
    subdirectory: "Input"
  )!

  mutating func run() throws {
    let input = try String(contentsOf: fileURL, encoding: .utf8)
      .split(separator: " ")
      .map(String.init)
      .compactMap(Int.init)
      .map { ($0, 1) } // [stone: 1, stone: 1, ...]

    var stones: [Int: Int] = Dictionary(uniqueKeysWithValues: input)

    for i in 1...75 {
      stones = solve(stones)
      if i == 25 { print(stones.values.reduce(0, +)) }
    }
    print(stones.values.reduce(0, +))
  }

  // Perform one blink
  private func solve(_ stones: [Int: Int]) -> [Int: Int] {
    var new: [Int: Int] = [:]
    for (stone, count) in stones {
      if stone == 0 {
        new[1, default: 0] += count
      } else if String(stone).count % 2 == 0 {
        new[(Int(String(stone).prefix(String(stone).count / 2))!), default: 0] += count
        new[(Int(String(stone).suffix(String(stone).count / 2))!), default: 0] += count
      } else {
        new[stone * 2024, default: 0] += count
      }
    }
    return new
  }
}
