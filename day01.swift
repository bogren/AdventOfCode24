import Foundation
import ArgumentParser

struct Day1: ParsableCommand {
  private var fileURL = Bundle.module.url(
    forResource: "day1",
    withExtension: nil,
    subdirectory: "Input"
  )!

  mutating func run() throws {
    let input = try String(contentsOf: fileURL)
    let lines = input.components(separatedBy: .newlines)
  }
}
