import SwiftUI

struct HistoryOfOperationView: View {
    @Binding var history: [(String, String)]
    
    var body: some View {
        // MARK: Background
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                // MARK: List of Expression History
                List(history.indices, id: \.self) { index in
                    HStack {
                        Text(history[index].0)
                        Spacer()
                        Text(history[index].1)
                    }
                    .foregroundColor(.black)
                }
                // MARK: Display
                HStack {
                    Spacer()
                    
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Історія операцій")
                        .font(.title2)
                        .foregroundColor(.blue)
                }
            }
        }
    }
}

#Preview {
    HistoryOfOperationView(history: .constant([]))
}
