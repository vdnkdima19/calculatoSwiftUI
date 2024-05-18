import SwiftUI

struct ContentView: View {
    // MARK: Property
    let allButtons : [[Buttons]] = [
    [.clear, .empty, .empty, .devide],
    [.seven, .eight, .nine, .multiple],
    [.four, .five, .six, .minus],
    [.one, .two, .three, .plus],
    [.zero, .demical, .equel]]
    
    var body: some View {
        // MARK: Background
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack {
                Spacer()
        // MARK: Display
        HStack {
            Spacer()
            Text("0")
                .font(.system(size: 90))
                .foregroundColor(.white)
            .frame(width: 370, height: 130, alignment: .trailing)
            .padding(.trailing)
        }
        // MARK: Buttons
        ForEach(allButtons, id: \.self) {
            row in HStack {
                ForEach(row, id: \.self) {
                    item in if item == .zero {
                        Button {
                            
                        } label: {
                            Text(item.rawValue)
                                .frame(width: 180, height: 90)
                                .foregroundColor(.white)
                                .font(.system(size: 40))
                                .background(item.colorOfButtons)
                                .cornerRadius(45)
                        }
                    } else {
                        Button {
                            
                        } label: {
                            Text(item.rawValue)
                                .frame(width: 90, height: 90)
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
#Preview {
    ContentView()
}
