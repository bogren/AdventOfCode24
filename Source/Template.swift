import Foundation
import ArgumentParser

struct DayXX: ParsableCommand {
  private var fileURL = Bundle.module.url(
    forResource: "day",
    withExtension: nil,
    subdirectory: "Input"
  )!


  mutating func run() throws {
    let input = try String(contentsOf: fileURL, encoding: .utf8)
      .split(separator: "\n")
    print(input)
  }
}
