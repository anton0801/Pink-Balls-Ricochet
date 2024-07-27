import SwiftUI

struct GameOverView: View {
    
    @Environment(\.presentationMode) var pres
    
    var body: some View {
        VStack {
            Spacer()
            
            ShadowTextView(text: "GAME OVER")
            ShadowTextView(text: "You missed, try again.", textSize: 24)
            
            HStack {
                Button {
                    pres.wrappedValue.dismiss()
                } label: {
                    Image("home_btn")
                        .resizable()
                        .frame(width: 62, height: 62)
                }
                .padding(.trailing)
                Button {
                    NotificationCenter.default.post(name: Notification.Name("restart_game"), object: nil, userInfo: nil)
                } label: {
                    Image("restart_b")
                        .resizable()
                        .frame(width: 62, height: 62)
                }
                .padding(.leading)
            }
            
            Spacer()
        }
        .background(
            Image("game_image")
                .resizable()
                .frame(minWidth: UIScreen.main.bounds.width, minHeight: UIScreen.main.bounds.height)
                .scaledToFit()
                .ignoresSafeArea()
        )
    }
}

#Preview {
    GameOverView()
}
