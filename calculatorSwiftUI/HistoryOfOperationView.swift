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
        }
        
        // MARK: Navigation Title and Appearance
        .navigationTitle("Історія операцій")
                .onAppear {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .black
        appearance.titleTextAttributes = [
                .foregroundColor: UIColor.white,
                .font: UIFont.systemFont(ofSize: 24)
        ]
                    
        let backImage = UIImage(systemName: "chevron.left")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        appearance.setBackIndicatorImage(backImage, transitionMaskImage: backImage)

        appearance.backButtonAppearance.normal.titleTextAttributes = [
                        .foregroundColor: UIColor.clear
        ]
                    
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().tintColor = .white
        }
    }
}
#Preview {
    HistoryOfOperationView(history: .constant([]))
}

