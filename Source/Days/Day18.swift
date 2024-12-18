import Foundation
import ArgumentParser
import Collections

struct Day18: ParsableCommand {
  private var fileURL = Bundle.module.url(
    forResource: "day18",
    withExtension: nil,
    subdirectory: "Input"
  )!

  private var coordinates: [Point] = []

  mutating func run() throws {
    coordinates = try String(contentsOf: fileURL, encoding: .utf8)
      .split(separator: "\n")
      .compactMap {
        let first = $0.split(separator: ",")[0]
        let second = $0.split(separator: ",")[1]
        return Point(first, second)
      }
    let grid: [[String]] = Array(repeating: Array(repeating: ".", count: 71), count: 71)

    let part1 = solve(grid: grid, start: Point(0, 0), n: 1024)
    print(part1)

    var left = 0
    var right = coordinates.count - 1
    while left < right {
      let mid = (left + right) / 2
      if solve(grid: grid, start: Point(0, 0), n: mid) != -1 {
        left = mid + 1
      } else {
        right = mid
      }
    }
    print(coordinates[left - 1]) // Part 2
  }

  private func solve(grid: [[String]], start: Point, n: Int) -> Int {
    var grid = grid
    for coordinate in coordinates.prefix(n) {
      grid[coordinate.y][coordinate.x] = String("#")
    }
    var path: Set<Point> = []
    var deque: Deque<Point> = [start]
    while let current = deque.popFirst() {
      for dir in [(0, 1), (0, -1), (1, 0), (-1, 0)] {
        var next = current + dir
        guard let n = grid[safe: next.y]?[safe: next.x], n == ".", !path.contains(next) else {
          continue
        }
        if next.x == 70 && next.y == 70 {
          return next.d + 1
        }
        path.insert(next)
        next.d += 1
        deque.append(next)
      }
    }
    return -1
  }
}
