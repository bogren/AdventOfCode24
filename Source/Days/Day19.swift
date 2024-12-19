import Foundation
import ArgumentParser

struct Day19: ParsableCommand {
  private var fileURL = Bundle.module.url(
    forResource: "day19",
    withExtension: nil,
    subdirectory: "Input"
  )!

  private var seen: [String: Int] = [:]

  mutating func run() throws {
    let input = try String(contentsOf: fileURL, encoding: .utf8)
      .split(separator: "\n")
    let towels = Set(input[0].split(separator: ", "))
    let patterns = input.dropFirst()
    let longest = towels.max(by: { $0.count < $1.count })!.count

    var part1 = 0
    var part2 = 0
    for pattern in patterns {
      let count = solve(String(pattern), longest, towels)
      if count != 0 { part1 += 1 }
      part2 += count
    }
    print(part1)
    print(part2)
  }

  private mutating func solve(_ pattern: String, _ longest: Int, _ towels: Set<Substring>) -> Int {
    if pattern == "" { return 1 }
    if let seen = seen[pattern] { return seen }
    var count = 0
    for i in 1...(min(pattern.count, longest)) {
      if towels.contains(pattern.prefix(i)) {
        seen[pattern, default: 0] += count
        count += solve(String(pattern.dropFirst(i)), longest, towels)
      }
    }
    seen[pattern, default: 0] = count
    return count
  }
}

