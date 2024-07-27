import SwiftUI

struct CloseButtonView: View {
    var body: some View {
        Image("close")
            .resizable()
            .frame(width: 52, height: 52)
    }
}

#Preview {
    CloseButtonView()
}
