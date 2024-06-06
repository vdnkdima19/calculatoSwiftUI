import SwiftUI

struct CalculatorButton: View {
    let title: String
    let width: CGFloat
    let height: CGFloat
    let backgroundColor: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }) {
            Text(title)
                .frame(width: width, height: height)
                .foregroundColor(.white)
                .font(.system(size: 40))
                .background(backgroundColor)
                .cornerRadius(height / 2)
        }
    }
}
