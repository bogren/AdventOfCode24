import Foundation
import ArgumentParser
import RegexBuilder

public extension Collection {
  subscript (safe index: Index) -> Element? {
    return indices.contains(index) ? self[index] : nil
  }
}

struct Day4: ParsableCommand {
  private var fileURL = Bundle.module.url(
    forResource: "day04",
    withExtension: nil,
    subdirectory: "Input"
  )!

  mutating func run() throws {
    let input = try String(contentsOf: fileURL, encoding: .utf8)

    let grid = input
      .split(separator: "\n")
      .map {
        $0.split(separator: "")
          .map(String.init)
      }

    var part1 = 0
    var part2 = 0

    for i in 0..<grid.count{
      for j in 0..<grid[i].count {
        // -> <- ^ v /^ \v \^ /v

        if grid[i][j] == "X"
            && grid[safe: i+1]?[j] == "M"
            && grid[safe: i+2]?[j] == "A"
            && grid[safe: i+3]?[j] == "S" {
          part1 += 1
        }

        if grid[i][j] == "X"
            && grid[safe: i-1]?[j] == "M"
            && grid[safe: i-2]?[j] == "A"
            && grid[safe: i-3]?[j] == "S" {
          part1 += 1
        }

        if grid[i][j] == "X"
            && grid[i][safe: j+1] == "M"
            && grid[i][safe: j+2] == "A"
            && grid[i][safe: j+3] == "S" {
          part1 += 1
        }

        if grid[i][j] == "X"
            && grid[safe: i+1]?[safe: j+1] == "M"
            && grid[safe: i+2]?[safe: j+2] == "A"
            && grid[safe: i+3]?[safe: j+3] == "S" {
          part1 += 1
        }

        if grid[i][j] == "X"
            && grid[safe: i+1]?[safe: j-1] == "M"
            && grid[safe: i+2]?[safe: j-2] == "A"
            && grid[safe: i+3]?[safe: j-3] == "S" {
          part1 += 1
        }

        if grid[i][j] == "X"
            && grid[safe:i-1]?[safe: j+1] == "M"
            && grid[safe: i-2]?[safe: j+2] == "A"
            && grid[safe:i-3]?[safe: j+3] == "S" {
          part1 += 1
        }

        if grid[i][j] == "X"
            && grid[safe: i-1]?[safe: j-1] == "M"
            && grid[safe: i-2]?[safe: j-2] == "A"
            && grid[safe: i-3]?[safe: j-3] == "S" {
          part1 += 1
        }

        if grid[i][j] == "X"
            && grid[i][safe: j-1] == "M"
            && grid[i][safe: j-2] == "A"
            && grid[i][safe: j-3] == "S" {
          part1 += 1
        }

        // X-MAS
        if grid[i][j] == "A"
            && (grid[safe: i-1]?[safe: j-1] == "M"
                && grid[safe: i+1]?[safe: j-1] == "S")
            &&
            (grid[safe: i-1]?[safe: j+1] == "M"
             && grid[safe: i+1]?[safe: j+1] == "S") {
          part2 += 1
        }

        if grid[i][j] == "A"
            && (grid[safe: i-1]?[safe: j-1] == "S"
                && grid[safe: i+1]?[safe: j-1] == "M")
            && (grid[safe: i-1]?[safe: j+1] == "S"
                && grid[safe: i+1]?[safe: j+1] == "M") {
          part2 += 1
        }

        if grid[i][j] == "A"
            && (grid[safe: i-1]?[safe: j-1] == "M"
                && grid[safe: i+1]?[safe: j-1] == "M")
            &&
            (grid[safe: i-1]?[safe: j+1] == "S"
             && grid[safe: i+1]?[safe: j+1] == "S") {
          part2 += 1
        }

        if grid[i][j] == "A"
            && (grid[safe: i-1]?[safe: j-1] == "S"
                && grid[safe: i+1]?[safe: j-1] == "S")
            &&
            (grid[safe: i-1]?[safe: j+1] == "M"
             && grid[safe: i+1]?[safe: j+1] == "M") {
          part2 += 1
        }
      }
    }

    print(part1)
    print(part2)
  }
}
