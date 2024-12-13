import Foundation
import ArgumentParser
import Collections
import RegexBuilder
import simd

struct Day13: ParsableCommand {
  private var fileURL = Bundle.module.url(
    forResource: "day13",
    withExtension: nil,
    subdirectory: "Input"
  )!

  mutating func run() throws {
    let machines = try String(contentsOf: fileURL, encoding: .utf8)
      .split(separator: "\n\n")

    let regexA = Regex {
      "Button A: X+"
      Capture { OneOrMore(.digit) }
      ", Y+"
      Capture { OneOrMore(.digit) }
    }

    let regexB = Regex {
      "Button B: X+"
      Capture { OneOrMore(.digit) }
      ", Y+"
      Capture { OneOrMore(.digit) }
    }

    let regexPrice = Regex {
      "Prize: X="
      Capture { OneOrMore(.digit) }
      ", Y="
      Capture { OneOrMore(.digit) }
    }

    var part1 = 0
    var part2 = 0
    let lol = 10_000_000_000_000

    for buttons in machines {
      let buttonA = buttons.matches(of: regexA).map { Tuple(Int($0.output.1)!, Int($0.output.2)!) }.first!
      let buttonB = buttons.matches(of: regexB).map { Tuple(Int($0.output.1)!, Int($0.output.2)!) }.first!
      let prize = buttons.matches(of: regexPrice).map { Tuple(Int($0.output.1)!, Int($0.output.2)!) }.first!

      part1 += solve(buttonA, buttonB, prize)
      part2 += solve(buttonA, buttonB, prize, lol)
    }

    print(part1)
    print(part2)
  }

  private func solve(_ first: Tuple, _ second: Tuple, _ prize: Tuple, _ unit: Int = 0) -> Int {
    // For future me reading this.
    // https://developer.apple.com/documentation/accelerate/working_with_matrices#2960597
    let matrix = simd_double2x2(rows: [
      simd_double2(Double(first.x), Double(second.x)),
      simd_double2(Double(first.y), Double(second.y))
    ])
    let vector = simd_double2(Double(prize.x + unit), Double(prize.y + unit))
    let result = simd_mul(matrix.inverse, vector).rounded(.toNearestOrEven)
    let rxa = Int(result.x) * first.x, rxb = Int(result.y) * second.x
    let rya = Int(result.x) * first.y, ryb = Int(result.y) * second.y
    if rxa + rxb == (prize.x + unit) && rya + ryb == (prize.y + unit) {
      return 3 * Int(result.x) + Int(result.y)
    }
    return 0
  }
}
