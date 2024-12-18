import Foundation
import ArgumentParser
import RegexBuilder

struct Day14: ParsableCommand {
  private var fileURL = Bundle.module.url(
    forResource: "day14",
    withExtension: nil,
    subdirectory: "Input"
  )!

  struct Robot {
    var p: Tuple
    var v: Tuple
  }

  mutating func run() throws {
    let input = try String(contentsOf: fileURL, encoding: .utf8)
      .split(separator: "\n")

   let regex = try! Regex("-?[0-9]{0,10}")

    var robots: [Robot] = []
    for line in input {
      if let result = try? regex.firstMatch(in: line) {
        print(result)
      }
      // robots.append(Robot(p: posistion, v: velocity))
    }


    for _ in 1...100 {

    }

  }

  // 11x7
  private func move() {

  }
}
