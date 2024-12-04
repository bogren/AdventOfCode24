import Foundation
import ArgumentParser
import RegexBuilder

struct Day3: ParsableCommand {
  private var fileURL = Bundle.module.url(
    forResource: "day03",
    withExtension: nil,
    subdirectory: "Input"
  )!

  mutating func run() throws {
    let input = try String(contentsOf: fileURL, encoding: .utf8)

    let part1 = solve(input)
    print(part1)

    let part2 = solve(input, dont: false)
    print(part2)
  }

  private func solve(_ input: String, dont: Bool? = nil) -> Int {
    guard let dont else { return parseAndMultiply(input) }
    let separator = dont ? "do()" : "don't()"
    let parts = input.split(separator: separator, maxSplits: 1)
    if parts.count == 0 { return 0 }
    if parts.count == 1 { return parseAndMultiply(String(parts[0])) }
    return dont
    ? solve(String(parts[1]), dont: false)
    : parseAndMultiply(String(parts[0])) + solve(String(parts[1]), dont: true)
  }

  private func parseAndMultiply(_ input: String) -> Int {
    let regex = Regex {
      "mul("
      Capture { OneOrMore(.digit) }
      ","
      Capture { OneOrMore(.digit) }
      ")"
    }
    return input.matches(of: regex)
      .reduce(into: 0) { $0 += Int($1.output.1)! * Int($1.output.2)! }
  }
}
