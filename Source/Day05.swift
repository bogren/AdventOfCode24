import Foundation
import ArgumentParser

extension Array {
  func tuple() -> (Element,Element) {
    return (self[0], self[1])
  }
}

struct Day5: ParsableCommand {
  private var fileURL = Bundle.module.url(
    forResource: "day05",
    withExtension: nil,
    subdirectory: "Input"
  )!

  mutating func run() throws {
    let input = try String(contentsOf: fileURL, encoding: .utf8).split(separator: "\n\n")
    let rules = input[0].split(separator: "\n"), pages = input[1].split(separator: "\n")
    var correct: [[Int]] = []
    for page in pages {
      let page = page.split(separator: ",").compactMap(String.init).compactMap(Int.init)
      var ok = true
      for rule in rules {
        let tuple = rule.split(separator: "|").map { Int($0)! }.tuple()
        if let first = page.firstIndex(of: tuple.0), let second = page.firstIndex(of: tuple.1), first > second {
          ok = false
        }
      }
      if ok { correct.append(page) }
    }

    let part1 = correct.reduce(into: 0) { partialResult, inner in
      partialResult += inner[(inner.count - 1) / 2]
    }

    print(part1)
  }
}
