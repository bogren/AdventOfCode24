import Foundation
import ArgumentParser
import Collections

struct Day10: ParsableCommand {
  private var fileURL = Bundle.module.url(
    forResource: "day10",
    withExtension: nil,
    subdirectory: "Input"
  )!

  mutating func run() throws {
    let grid = try String(contentsOf: fileURL, encoding: .utf8)
      .split(separator: "\n")
      .map { $0.split(separator: "").map(String.init).compactMap(Int.init) }

    var startingPositions = Set<Tuple>()
    for i in 0..<grid.count {
      for j in 0..<grid[i].count {
        if grid[i][j] == 0 {
          startingPositions.insert(Tuple(j, i))
        }
      }
    }
    var part1 = 0
    for start in startingPositions {
      part1 += path(grid: grid, i: start.x, j: start.y)
    }

    print(part1)
  }

  private func path(grid: [[Int]], i: Int, j: Int) -> Int {
    var paths: Set<Tuple> = []
    var deque: Deque<Tuple> = [Tuple(i, j)]
    var count = 0
    while let current = deque.popFirst() {
      if paths.contains(current) { continue }
      paths.insert(current)
      if grid[current.y][current.x] == 9 {
        count += 1
      }
      for dir in [Tuple(0, 1), Tuple(0, -1), Tuple(1, 0), Tuple(-1, 0)] {
        let next = current + dir
        guard let neighbor = grid[safe: next.y]?[safe: next.x], // I should fix this
              grid[current.y][current.x] + 1 == neighbor else { continue }
        deque.append(next)
      }
    }
    return count
  }
}
