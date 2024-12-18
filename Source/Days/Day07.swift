import Foundation
import ArgumentParser

struct Day7: ParsableCommand {
  private var fileURL = Bundle.module.url(
    forResource: "day07",
    withExtension: nil,
    subdirectory: "Input"
  )!

  mutating func run() throws {
    let input = try String(contentsOf: fileURL, encoding: .utf8)
      .components(separatedBy: .newlines)
      .dropLast()

    var testValues: [Int] = []
    for line in input {
      let sum = line.split(separator: ":")[0].intValue
      let numbers = line.split(separator: ":")[1]
        .split(separator: " ")
        .map(\.intValue)

      if valid(sum, numbers) {
        testValues.append(sum)
      }
    }

    print(testValues.reduce(0, +))
  }

  private func valid(_ target: Int, _ numbers: [Int]) -> Bool {
    if numbers.count == 1 { return numbers[0] == target }
    guard let last = numbers.last else { return false }

    if target % last == 0 && valid(target / last, numbers.dropLast()) {
      return true
    }

    if target >= last && valid(target - last, numbers.dropLast()) {
      return true
    }

    return false
  }
}

