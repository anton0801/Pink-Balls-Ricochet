import SwiftUI

struct ContentView: View {
    
    @StateObject var userManager: UserManager = UserManager()
    
    private var lastLevel: Int {
        get {
            return UserDefaults.standard.integer(forKey: "last_level")
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                HStack {
                    NavigationLink(destination: SettingsGameView()
                        .navigationBarBackButtonHidden(true)) {
                        ZStack {
                            Image("button_image")
                                .resizable()
                                .frame(width: 180, height: 70)
                            ShadowTextView(text: "SETTINGS", textColor: Color.init(red: 1, green: 27/255, blue: 119/255), shadowColor: .white, textSize: 20)
                                .offset(y: -5)
                        }
                    }
                    
                    NavigationLink(destination: InfoGameView()
                        .navigationBarBackButtonHidden(true)) {
                        ZStack {
                            Image("button_image")
                                .resizable()
                                .frame(width: 180, height: 70)
                            ShadowTextView(text: "INFO", textColor: Color.init(red: 1, green: 27/255, blue: 119/255), shadowColor: .white, textSize: 20)
                                .offset(y: -5)
                        }
                    }
                }
                HStack {
//                    NavigationLink(destination: EmptyView()) {
//                        ZStack {
//                            Image("button_image")
//                                .resizable()
//                                .frame(width: 180, height: 70)
//                            ShadowTextView(text: "UPGRADE", textColor: Color.init(red: 1, green: 27/255, blue: 119/255), shadowColor: .white, textSize: 20)
//                                .offset(y: -5)
//                        }
//                    }
                    NavigationLink(destination: MissionsGameView()
                        .navigationBarBackButtonHidden(true)
                        .environmentObject(userManager)) {
                        ZStack {
                            Image("button_image")
                                .resizable()
                                .frame(width: 180, height: 70)
                            ShadowTextView(text: "MISSIONS", textColor: Color.init(red: 1, green: 27/255, blue: 119/255), shadowColor: .white, textSize: 20)
                                .offset(y: -5)
                        }
                    }
                }
                
                Spacer()
                Image("home_logo")
                    .resizable()
                    .frame(width: 300, height: 400)
                    .scaledToFill()
                
                Spacer()
                NavigationLink(destination: PlayGameView(level: lastLevel)
                    .navigationBarBackButtonHidden(true)
                    .environmentObject(userManager)) {
                    ZStack {
                        Image("button_image")
                            .resizable()
                            .frame(width: 200, height: 80)
                        ShadowTextView(text: "Play", textColor: Color.init(red: 1, green: 27/255, blue: 119/255), shadowColor: .white)
                            .offset(y: -5)
                    }
                }
            }
            .background(
                Image("home_image")
                    .resizable()
                    .frame(minWidth: UIScreen.main.bounds.width, minHeight: UIScreen.main.bounds.height)
                    .scaledToFit()
                    .ignoresSafeArea()
            )
            .onAppear {
                let lastLevel = UserDefaults.standard.integer(forKey: "last_level")
                if lastLevel == 0 {
                    UserDefaults.standard.set(1, forKey: "last_level")
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    ContentView()
        .environmentObject(UserManager())
}
