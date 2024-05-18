import SwiftUI

struct ContentView: View {
    // MARK: Property
    @State private var value = "0"
    @State private var number: Double = 0.0
    @State private var currentOperation: Operation = .emptyState
    @State private var history: [(String, String)] = []
    
    let allButtons : [[Buttons]] = [
        [.clear, .emptyFirst, .emptySecond, .divide],
        [.seven, .eight, .nine, .multiple],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .plus],
        [.zero, .demical, .equel]]
    
    var body: some View {
        NavigationView {
            
            // MARK: Background
            ZStack {
                Color.black
                    .ignoresSafeArea()
                
                // MARK: Navigation
                VStack {
                    HStack {
                        NavigationLink(destination: HistoryOfOperationView(history: $history)) {
                            Image(systemName: "list.bullet.rectangle.portrait.fill")
                                .font(.system(size: 42))
                                .foregroundColor(.white)
                                .padding(.leading)
                        }
                        Spacer()
                    }
                    
                    // MARK: Display
                    HStack {
                        Spacer()
                        Text(formatValue(value))
                            .font(.system(size: 60))
                            .foregroundColor(.white)
                            .frame(width: 370, height: 150, alignment: .trailing)
                            .padding(.trailing)
                    }
                    
                    // MARK: Buttons
                    ForEach(allButtons, id: \.self) {
                        row in HStack {
                            ForEach(row, id: \.self) {
                                item in if item == .zero {
                                    Button {
                                        isPressed(item: item)
                                    } label: {
                                        Text(item.rawValue)
                                            .frame(width: 170, height: 80)
                                            .foregroundColor(.white)
                                            .font(.system(size: 40))
                                            .background(item.colorOfButtons)
                                            .cornerRadius(45)
                                    }
                                } else if item == .emptyFirst || item == .emptySecond {
                                        Text(item.rawValue)
                                            .frame(width: 85, height: 85)
                                            .foregroundColor(.white)
                                            .cornerRadius(45)
                                } else {
                                    Button {
                                        isPressed(item: item)
                                    } label: {
                                        Text(item.rawValue)
                                            .frame(width: 85, height: 85)
                                            .foregroundColor(.white)
                                            .font(.system(size: 40))
                                            .background(item.colorOfButtons)
                                            .cornerRadius(45)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    // MARK: Buttons Action
    func isPressed(item: Buttons) {
        if item != .equel && item != .clear && value == "Помилка" {
                value = "0"
        }
        
        switch item {
        case .plus:
            currentOperation = .addition
            number = Double(value.replacingOccurrences(of: ",", with: ".")) ?? 0
            value = "0"
        case .minus:
            currentOperation = .subtraction
            number = Double(value.replacingOccurrences(of: ",", with: ".")) ?? 0
            value = "0"
        case .multiple:
            currentOperation = .multiplication
            number = Double(value.replacingOccurrences(of: ",", with: ".")) ?? 0
            value = "0"
        case .divide:
            currentOperation = .division
            number = Double(value.replacingOccurrences(of: ",", with: ".")) ?? 0
            value = "0"
        case .demical:
            if !value.contains(",") {
                value += ","
            }
        case .equel:
            if let currentValue = Double(value.replacingOccurrences(of: ",", with: ".")) {
                let result = definitionOperation(currentValue)
                let expression = "\(number) \(operationSymbol(for: currentOperation)) \(currentValue)"
                let formattedResult = convertResult(result)
                history.append((expression, formattedResult))
                value = formattedResult
            }
        case .clear:
            value = "0"
        default:
            if value == "0" {
                value = item.rawValue
            } else {
                value += item.rawValue
            }
        }
    }
    
    // MARK: Helper Calculate
    func definitionOperation(_ currentValue: Double) -> Double {
        switch currentOperation {
        case .addition:
            return number + currentValue
        case .subtraction:
            return number - currentValue
        case .multiplication:
            return number * currentValue
        case .division:
            return number / currentValue
        default:
            return currentValue
        }
    }
    
    // MARK: Remove zero of integer Result
    func convertResult(_ result: Double) -> String {
        if result.isInfinite {
                return "Помилка"
        }
        
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 6
        formatter.decimalSeparator = ","
            
        return formatter.string(from: NSNumber(value: result)) ?? "\(result)"
    }
    
    // MARK: Max size value to 9 characters
    func formatValue(_ value: String) -> String {
        if value.count > 9 {
            let index = value.index(value.startIndex, offsetBy: 9)
                return String(value[..<index])
        }
        return value
    }
    
    // MARK: Operation Symbol Conversion
    func operationSymbol(for operation: Operation) -> String {
        switch operation {
        case .addition:
            return "+"
        case .subtraction:
            return "-"
        case .multiplication:
            return "x"
        case .division:
            return "/"
        default:
            return ""
        }
    }
}
#Preview {
    ContentView()
}
