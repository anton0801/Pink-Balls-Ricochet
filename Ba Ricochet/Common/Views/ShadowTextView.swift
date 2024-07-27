import SwiftUI

struct ShadowTextView: View {
    
    var text: String
    var textColor: Color = .white
    var shadowColor: Color = .black
    var textSize: CGFloat = 32
    
    var body: some View {
        ZStack {
            Text(text)
                .font(.custom("MochiyPopOne-Regular", size: textSize + 1))
                .foregroundColor(shadowColor)
                .offset(x: 0.5, y: 0.5)
            Text(text)
                .font(.custom("MochiyPopOne-Regular", size: textSize))
                .foregroundColor(textColor)
        }
    }
}

#Preview {
    ShadowTextView(text: "Test", textColor: .white)
}
