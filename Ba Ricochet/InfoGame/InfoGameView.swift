import SwiftUI

struct InfoGameView: View {
    
    @Environment(\.presentationMode) var pres
    
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
            
            Text("INFO")
                .font(.custom("MochiyPopOne-Regular", size: 32))
                .foregroundColor(.white)
            Text("Calculate the trajectory of the balloon to avoid all the obstacles and get to all the desired objects")
                .frame(width: 300)
                .multilineTextAlignment(.center)
                .font(.custom("MochiyPopOne-Regular", size: 24))
                .foregroundColor(.white)
            
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
    InfoGameView()
}
