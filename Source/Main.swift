@preconcurrency
import ArgumentParser
import Foundation

@main
struct AdventOfCode: ParsableCommand {

  private static let days: [ParsableCommand.Type] = [
    Day1.self,
    Day2.self,
    Day3.self,
    Day4.self,
    Day5.self
  ]

  static let configuration = CommandConfiguration(
    abstract: "Advent of Code 2024 🎄",
    subcommands: days,
    helpNames: .shortAndLong
  )
}
