import Foundation
import ArgumentParser
import Collections
import RegexBuilder

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
    for buttons in machines {
      let buttonA = buttons.matches(of: regexA).map { Tuple(Int($0.output.1)!, Int($0.output.2)!) }.first!
      let buttonB = buttons.matches(of: regexB).map { Tuple(Int($0.output.1)!, Int($0.output.2)!) }.first!
      let prize = buttons.matches(of: regexPrice).map { Tuple(Int($0.output.1)!, Int($0.output.2)!) }.first!

      for a in 0..<100 {
        for b in 0..<100 {
          if prize == a * buttonA + b * buttonB {
            part1 += 3 * a + b
          }
        }
      }
    }
    print(part1)
  }
}
