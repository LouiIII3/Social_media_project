//
//  UserNameView.swift
//  Clone_instagram
//
//  Created by Taewon Yoon on 12/17/23.
//

import SwiftUI

struct UserNameView: View {
    
//    @Environment(RegisterViewModel.self) private var userinfo
    @EnvironmentObject var register: RegisterViewModel
    @Binding var path: [String]

    @State private var userid = ""
    @State private var pressed = false
    
    var buttonHeight: CGFloat = 40
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.login, Color.loginColor2, Color.loginColor3]), startPoint: .topLeading, endPoint: .trailing)
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Text("사용자 이름 만들기")
                        .font(.title3)
                        .bold()
                    Spacer()
                }.padding()
                
                HStack {
                    Text("사용자 이름을 추가하거나 추천 이름을 사용하세요. 언제든지 변경할 수 있습니다.")
                        .font(.callout)
                    Spacer()
                }.padding(.horizontal)
                
                TextField("사용자 이름을 입력하세요", text: $userid)
                    .modifier(customTextFieldModifier(roundedCorners: 15, textColor: .defaultText))
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                
                Button(action: { pressed.toggle() }, label: {
                    Text("다음")
                        .frame(maxWidth: .infinity)
                        .frame(height: 40)
                })
                .buttonStyle(customButtonStyle(labelColor: Color.white, backgroundColor: Color.accentColor, borderColor: Color.accentColor))
                .navigationDestination(isPresented: $pressed) {
                    PhoneNumView(path: $path)
                }
                
                
                Spacer()
            } //VSTACK
        } //ZSTACK
        .onChange(of: userid) {
            register.model.userid = userid
        }
    }
}

//#Preview {
//    UserNameView()
//        .environmentObject(RegisterViewModel())
//}
