import Foundation
import ArgumentParser

struct Day3: ParsableCommand {
  private var fileURL = Bundle.module.url(
    forResource: "day03",
    withExtension: nil,
    subdirectory: "Input"
  )!

  mutating func run() throws {
    let input = try String(contentsOf: fileURL, encoding: .utf8)

    print(input)
  }
}

