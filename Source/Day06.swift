import Foundation
import ArgumentParser

struct Tuple: Hashable {
  let x: Int
  let y: Int

  init(_ x: Int, _ y: Int) {
    self.x = x
    self.y = y
  }
}

extension Tuple {
  static func +(first: Tuple, second: Tuple) -> Tuple {
    return Tuple(first.x + second.x, first.y + second.y)
  }

  func rotate() -> Tuple {
    return switch self {
    case Tuple(0, 1): Tuple(-1, 0)
    case Tuple(1, 0): Tuple(0, 1)
    case Tuple(0, -1): Tuple(1, 0)
    case Tuple(-1, 0): Tuple(0, -1)
    default: fatalError()
    }
  }
}

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
