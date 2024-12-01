import Foundation
import ArgumentParser

struct Day1: ParsableCommand {
  private var fileURL = Bundle.module.url(
    forResource: "day01",
    withExtension: nil,
    subdirectory: "Input"
  )!

  mutating func run() throws {
    let input = try String(contentsOf: fileURL, encoding: .utf8)
    let lines = input.components(separatedBy: .newlines).dropLast()

    var left: [Int] = [], right: [Int] = []
    var lookup: [Int: Int] = [:]

    for line in lines {
      let tuple = line.split(separator: "   ")
      let first = Int(tuple[0])!, second = Int(tuple[1])!
      left.append(first)
      right.append(second)
      lookup[second, default: 0] += 1
    }

    left = left.sorted()
    right = right.sorted()

    var part1 = 0
    for z in zip(left, right) {
      part1 += abs(z.0 - z.1)
    }
    print(part1)

    var part2 = 0
    for number in left {
      part2 += lookup[number, default: 0] * number
    }
    print(part2)
  }
}

