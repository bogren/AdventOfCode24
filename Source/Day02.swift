import Foundation
import ArgumentParser

struct Day2: ParsableCommand {
  private var fileURL = Bundle.module.url(
    forResource: "day02",
    withExtension: nil,
    subdirectory: "Input"
  )!

  mutating func run() throws {
    let input = try String(contentsOf: fileURL, encoding: .utf8)
    let lines = input.components(separatedBy: .newlines).dropLast()

    var part1 = 0
    var part2 = 0
    for line in lines {
      let numbers = line.split(separator: " ").map { Int($0)! }
      if isSafe(numbers) {
        part1 += 1
      }

      var isPart2Safe = false
      for i in 0...numbers.count - 1 {
        if isSafe(Array(numbers.prefix(i)) + numbers.suffix(from: i + 1)) {
          isPart2Safe = true
        }
      }
      if isPart2Safe { part2 += 1 }
    }

    print(part1)
    print(part2)
  }

  private func isSafe(_ numbers: [Int]) -> Bool {
    let pairs = zip(numbers, numbers.dropFirst())
    return pairs.allSatisfy { (first, second) in (1...3).contains(first - second)}
    || pairs.allSatisfy { (first, second) in (1...3).contains(second - first)}
  }
}

