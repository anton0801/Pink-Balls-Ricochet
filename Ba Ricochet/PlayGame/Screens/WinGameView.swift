import SwiftUI

struct WinGameView: View {
    
    @Environment(\.presentationMode) var pres
    
    var level: Int
    
    var body: some View {
        VStack {
            Spacer()
            
            ShadowTextView(text: "WIN")
            
            HStack {
                ZStack {
                    Image("level_bg")
                        .resizable()
                        .frame(width: 180, height: 80)
                    ShadowTextView(text: "Level \(level)", textSize: 24)
                }
                ZStack {
                    Image("mission_claim_btn")
                        .resizable()
                        .frame(width: 180, height: 80)
                    ShadowTextView(text: "+5", textSize: 24)
                        .offset(x: 20)
                }
            }
            
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
            
            Button {
                var lastLevel = UserDefaults.standard.integer(forKey: "last_level")
                if level == 10 {
                    UserDefaults.standard.set(1, forKey: "last_level")
                    lastLevel = 1
                }
                NotificationCenter.default.post(name: Notification.Name("restart_game"), object: nil, userInfo: ["level": lastLevel])
            } label: {
                Image("next_level_btn")
                    .resizable()
                    .frame(width: 200, height: 80)
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
    WinGameView(level: 1)
}
