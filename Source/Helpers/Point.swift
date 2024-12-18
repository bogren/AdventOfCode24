import Foundation

struct Point {
  var x: Int
  var y: Int
  var d: Int // Distance for e.g. Dijkstra's or BFS

  init(_ x: Int, _ y: Int) {
    self.x = x
    self.y = y
    self.d = 0
  }

  init?(_ x: Substring, _ y: Substring) {
    guard let x = Int(x), let y = Int(y) else { return nil }
    self.x = x
    self.y = y
    self.d = 0
  }

  init(_ x: Int, _ y: Int, _ d: Int) {
    self.x = x
    self.y = y
    self.d = d
  }
}

extension Point {
  static func +(first: Point, second: (x: Int, y: Int)) -> Point {
    return Point(first.x + second.x, first.y + second.y, first.d)
  }

  static func +(first: Point, second: (x: Int, y: Int, d: Int)) -> Point {
    return Point(first.x + second.x, first.y + second.y, first.d + second.d)
  }
}

extension Point: Equatable {
  static func == (lhs: Point, rhs: Point) -> Bool {
    lhs.x == rhs.x && lhs.y == rhs.y
  }
}

extension Point: Hashable {
  func hash(into hasher: inout Hasher) {
    hasher.combine(x)
    hasher.combine(y)
  }
}

extension Point: Decodable {

}

extension Point: CustomStringConvertible {
  var description: String {
    "(\(x), \(y))"
  }
}
