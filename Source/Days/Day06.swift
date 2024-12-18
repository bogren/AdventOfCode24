import Foundation
import ArgumentParser

struct Day6: ParsableCommand {
  private var fileURL = Bundle.module.url(
    forResource: "day06",
    withExtension: nil,
    subdirectory: "Input"
  )!

  mutating func run() throws {
    let grid = try String(contentsOf: fileURL, encoding: .utf8)
      .split(separator: "\n")
      .map { $0.split(separator: "").map(String.init) }

    var current = Tuple(0, 0)

    for row in grid.enumerated() {
      for col in row.element.enumerated() {
        if col.element == "^" {
          current = Tuple(col.offset, row.offset)
        }
      }
    }

    var dir = Tuple(0, -1)
    var visited: Set = [current]

    while true {
      let next = current + dir

      guard grid[safe: next.y]?[safe: next.x] != nil else {
        break
      }

      if grid[next.y][next.x] == "#" {
        dir = dir.rotate()
      } else {
        current = next
        visited.insert(next)
      }
    }

    print(visited.count)
  }
}
