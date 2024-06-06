import SwiftUI

enum Operation {
    case addition, subtraction, multiplication, division, emptyState
}

enum Buttons: String {
    case zero = "0"
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case plus = "+"
    case minus = "-"
    case multiple = "x"
    case divide = "/"
    case demical = ","
    case equel = "="
    case clear = "AC"
    
    var colorOfButtons : Color {
        switch self {
        case .clear:
            return Color.ColorOfClearButton
        case .divide, .multiple ,.minus, .plus, .equel:
            return Color.orange
        default:
            return Color.ColorOfNumbers
        }
    }
}


