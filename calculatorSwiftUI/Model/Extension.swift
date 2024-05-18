import SwiftUI

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
    case devide = "/"
    case demical = ","
    case equel = "="
    case clear = "AC"
    case empty = ""
    
    var colorOfButtons : Color {
        switch self {
        case .clear:
            return Color.LightGray
        case .devide, .multiple ,.minus, .plus, .equel:
            return Color.orange
        case .empty:
            return Color.black
        default:
            return Color.DarkGray
        }
    }
}
extension Color {
    static let LightGray = Color("LightGray")
    static let DarkGray = Color("DarkGray")
}

