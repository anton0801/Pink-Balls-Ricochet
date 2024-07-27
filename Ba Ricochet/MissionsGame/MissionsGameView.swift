import SwiftUI

struct MissionsGameView: View {
    
    @EnvironmentObject var userManager: UserManager
    @StateObject var viewModel = MissionsViewModel()
    @Environment(\.presentationMode) var pres
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer()
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
                        .offset(x: 20)
                    Spacer()
                    Button {
                        pres.wrappedValue.dismiss()
                    } label: {
                        CloseButtonView()
                    }
                }
                .padding(.horizontal)
                
                Text("MISSIONS")
                    .font(.custom("MochiyPopOne-Regular", size: 32))
                    .foregroundColor(.white)
                    .padding(.top)
                
                ForEach(viewModel.missions, id: \.id) { missionItem in
                    HStack {
                        VStack {
                            Text(missionItem.mission)
                                .font(.custom("MochiyPopOne-Regular", size: 14))
                                .foregroundColor(.white)
                                .shadow(color: .black, radius: 2)
                                .multilineTextAlignment(.center)
                        }
                        .frame(width: 250, height: 60)
                        .background(
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .fill(.white.opacity(0.4))
                                .blur(radius: 1.5)
                                .frame(width: 250, height: 60)
                        )
                        
                        Spacer()
                        
                        if viewModel.claimedMissions.contains(missionItem.id) {
                            ZStack {
                                Image("mission_claim_btn")
                                    .resizable()
                                    .frame(width: 90, height: 60)
                                Text("Claimed")
                                    .font(.custom("MochiyPopOne-Regular", size: 14))
                                    .foregroundColor(.white)
                                    .offset(x: 15)
                                    .shadow(color: .black, radius: 2)
                            }
                        } else {
                            Button {
                                if viewModel.isMissionCompleted(missionItem) {
                                    if let a = viewModel.claimPrize(for: missionItem) {
                                        userManager.addCredits(a)
                                    }
                                }
                            } label: {
                                ZStack {
                                    Image("mission_claim_btn")
                                        .resizable()
                                        .frame(width: 90, height: 60)
                                    Text("\(missionItem.prize)")
                                        .font(.custom("MochiyPopOne-Regular", size: 18))
                                        .foregroundColor(.white)
                                        .offset(x: 15)
                                        .shadow(color: .black, radius: 2)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .background(
                Image("home_image")
                    .resizable()
                    .frame(minWidth: UIScreen.main.bounds.width, minHeight: UIScreen.main.bounds.height)
                    .scaledToFit()
                    .ignoresSafeArea()
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    MissionsGameView()
        .environmentObject(UserManager())
}
