import SwiftUI

struct ContentView: View {
    // MARK: Property
    @State private var value = "0"
    @State private var numbers: [Double] = []
    @State private var operations: [Operation] = []
    @State private var currentOperation: Operation = .emptyState
    @State private var history: [(String, String)] = []
    
    let allButtons: [[Buttons]] = [
        [.seven, .eight, .nine, .multiple],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .plus],
        [.zero, .demical, .equel]
    ]
    
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
                    VStack {
                        HStack {
                            CalculatorButton(title: Buttons.clear.rawValue, width: 85, height: 85, backgroundColor: Buttons.clear.colorOfButtons) {
                                isPressed(item: .clear)
                            }
                            .padding(.leading, 15)
                            Spacer()
                            CalculatorButton(title: Buttons.divide.rawValue, width: 85, height: 85, backgroundColor: Buttons.divide.colorOfButtons) {
                                isPressed(item: .divide)
                            }
                            .padding(.trailing, 15)
                        }
                        ForEach(allButtons.indices, id: \.self) { rowIndex in
                            HStack {
                                ForEach(allButtons[rowIndex].indices, id: \.self) { columnIndex in
                                    let item = allButtons[rowIndex][columnIndex]
                                    let width: CGFloat = item == .zero ? 170 : 85
                                    CalculatorButton(title: item.rawValue, width: width, height: 85, backgroundColor: item.colorOfButtons) {
                                        isPressed(item: item)
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
        case .plus, .minus, .multiple, .divide:
            processOperation(item)
        case .demical:
            processDemical()
        case .equel:
            processEqual()
        case .clear:
            value = "0"
            numbers.removeAll()
            operations.removeAll()
        default:
            processNumber(item)
        }
    }
    
    // MARK: Process Number
    func processNumber(_ item: Buttons) {
        if value == "0" {
            value = item.rawValue
        } else {
            value += item.rawValue
        }
    }
    
    // MARK: Process Decimal
    func processDemical() {
        if !value.contains(",") {
            value += ","
        }
    }
    
    // MARK: Process Operation
    func processOperation(_ item: Buttons) {
        if let currentValue = Double(value.replacingOccurrences(of: ",", with: ".")) {
            numbers.append(currentValue)
            operations.append(item.toOperation())
            value = "0"
        }
    }
    
    // MARK: Process Equal
    func processEqual() {
        if let currentValue = Double(value.replacingOccurrences(of: ",", with: ".")) {
            numbers.append(currentValue)
            let result = calculateResult()
            let expression = createExpression()
            let formattedResult = convertResult(result)
            history.append((expression, formattedResult))
            value = formattedResult
            numbers.removeAll()
            operations.removeAll()
        }
    }
    
    // MARK: Calculate Result
    func calculateResult() -> Double {
        var result = numbers[0]
        for i in 1..<numbers.count {
            let currentOperation = operations[i - 1]
            result = applyOperation(result, with: numbers[i], operation: currentOperation)
        }
        return result
    }
    
    // MARK: Apply Operation
    func applyOperation(_ leftValue: Double, with rightValue: Double, operation: Operation) -> Double {
        switch operation {
        case .addition:
            return leftValue + rightValue
        case .subtraction:
            return leftValue - rightValue
        case .multiplication:
            return leftValue * rightValue
        case .division:
            return leftValue / rightValue
        default:
            return rightValue
        }
    }
    
    // MARK: Create Expression
    func createExpression() -> String {
        var expression = "\(numbers[0])"
        for i in 1..<numbers.count {
            expression += " \(operationSymbol(for: operations[i - 1])) \(numbers[i])"
        }
        return expression
    }
    
    // MARK: Remove zero of integer Result
    func convertResult(_ result: Double) -> String {
        if result.isInfinite || result.isNaN {
            return "Помилка"
        }
        
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 6
        formatter.decimalSeparator = ","
        
        if let formattedString = formatter.string(from: NSNumber(value: result)) {
            return formattedString
        } else {
            return "Помилка"
        }
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

extension Buttons {
    func toOperation() -> Operation {
        switch self {
        case .plus:
            return .addition
        case .minus:
            return .subtraction
        case .multiple:
            return .multiplication
        case .divide:
            return .division
        default:
            return .emptyState
        }
    }
}
