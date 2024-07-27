import SwiftUI

struct SettingsGameView: View {
    
    @Environment(\.presentationMode) var pres
    
    @State var countMusicSound = UserDefaults.standard.integer(forKey: "count_music") {
        didSet {
            UserDefaults.standard.set(countMusicSound, forKey: "count_music")
        }
    }
    @State var countSound = UserDefaults.standard.integer(forKey: "count_sound") {
        didSet {
            UserDefaults.standard.set(countSound, forKey: "count_sound")
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    pres.wrappedValue.dismiss()
                } label: {
                    CloseButtonView()
                }
            }
            .padding(.trailing)
            
            Spacer()
            
            Text("SETTINGS")
                .font(.custom("MochiyPopOne-Regular", size: 32))
                .foregroundColor(.white)
            
            HStack {
                Button {
                    if countMusicSound > 0 {
                        withAnimation(.linear(duration: 0.3)) {
                            countMusicSound -= 1
                        }
                    }
                } label: {
                    Image("minus_btn")
                        .resizable()
                        .frame(width: 52, height: 52)
                }
                
                VStack(spacing: 0) {
                    Text("Music")
                        .font(.custom("MochiyPopOne-Regular", size: 20))
                        .foregroundColor(.white)
                    ZStack(alignment: .leading) {
                        Image("settings_count_value_bg")
                            .resizable()
                            .frame(width: 150, height: 70)
                        HStack(spacing: 1) {
                            ForEach(0..<countMusicSound, id: \.self) { i in
                                Image("settings_counter_item")
                                    .resizable()
                                    .frame(width: 10, height: 50)
                            }
                        }
                        .padding(.horizontal, 10)
                    }
                }
                .padding(.leading, 24)
                
                Button {
                    if countMusicSound < 12 {
                        withAnimation(.linear(duration: 0.3)) {
                            countMusicSound += 1
                        }
                    }
                } label: {
                    Image("plus_btn")
                        .resizable()
                        .frame(width: 52, height: 52)
                }
                .padding(.leading, 24)
            }
            
            HStack {
                Button {
                    if countSound > 0 {
                        withAnimation(.linear(duration: 0.3)) {
                            countSound -= 1
                        }
                    }
                } label: {
                    Image("minus_btn")
                        .resizable()
                        .frame(width: 52, height: 52)
                }
                
                VStack(spacing: 0) {
                    Text("Sounds")
                        .font(.custom("MochiyPopOne-Regular", size: 20))
                        .foregroundColor(.white)
                    ZStack(alignment: .leading) {
                        Image("settings_count_value_bg")
                            .resizable()
                            .frame(width: 150, height: 70)
                        HStack(spacing: 1) {
                            ForEach(0..<countSound, id: \.self) { i in
                                Image("settings_counter_item")
                                    .resizable()
                                    .frame(width: 10, height: 50)
                            }
                        }
                        .padding(.horizontal, 10)
                    }
                }
                .padding(.leading, 24)
                
                Button {
                    if countSound < 12 {
                        withAnimation(.linear(duration: 0.3)) {
                            countSound += 1
                        }
                    }
                } label: {
                    Image("plus_btn")
                        .resizable()
                        .frame(width: 52, height: 52)
                }
                .padding(.leading, 24)
            }
            .padding(.top)
            
            Spacer()
        }
        .background(
            Image("home_image")
                .resizable()
                .frame(minWidth: UIScreen.main.bounds.width, minHeight: UIScreen.main.bounds.height)
                .scaledToFit()
                .ignoresSafeArea()
        )
    }
}

#Preview {
    SettingsGameView()
}
