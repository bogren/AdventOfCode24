import Foundation

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
