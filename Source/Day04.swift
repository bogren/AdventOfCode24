import Foundation
import ArgumentParser
import RegexBuilder

struct Day4: ParsableCommand {
  private var fileURL = Bundle.module.url(
    forResource: "day04",
    withExtension: nil,
    subdirectory: "Input"
  )!

  mutating func run() throws {
    let input = try String(contentsOf: fileURL, encoding: .utf8)
    let lines = input.components(separatedBy: .newlines).dropLast()
    
  }
}
