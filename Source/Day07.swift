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

    for line in input {
      print(line)
    }
  }
}

