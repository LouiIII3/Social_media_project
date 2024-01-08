//
//  PhoneNumValidation.swift
//  Clone_instagram
//
//  Created by Taewon Yoon on 12/17/23.
//

import SwiftUI

struct PhoneNumValidation: View {
    @EnvironmentObject var register: RegisterViewModel
    @State private var user = ""
    @State private var pressed = false
    @Binding var phoneNumber: String
    @Binding var path: [String]

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.login, Color.loginColor2, Color.loginColor3]), startPoint: .topLeading, endPoint: .trailing)
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Text("인증 코드 입력")
                        .font(.title3)
                        .bold()
                    Spacer()
                }.padding()
                
                HStack {
                    Text("To confirm your account, enter the 6-digit code we sent to ") + Text(phoneNumber).bold()
                    
                        .font(.callout)
                    Spacer()
                }.padding(.horizontal)
                
                TextField("휴대폰 번호", text: $user)
                    .modifier(customTextFieldModifier(roundedCorners: 15, textColor: .defaultText))
                    .keyboardType(.phonePad)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                
                Text("보안 및 로그인 목적으로 Instagram에서 보내는 SMS 알림을 수신할 수 있습니다.")
                    .font(.caption)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                
                
                Button(action: { pressed.toggle() }, label: {
                    Text("다음")
                        .frame(maxWidth: .infinity)
                        .frame(height: 40)
                })
                .buttonStyle(customButtonStyle(labelColor: Color.white, backgroundColor: Color.accentColor, borderColor: Color.accentColor))
                .navigationDestination(isPresented: $pressed) {
                    ProfilePictureView(path: $path)
                }
                
                Button(action: {}, label: {
                    Text("코드를 받지 못했습니다")
                        .frame(maxWidth: .infinity)
                        .frame(height: 40)
                })
                .buttonStyle(customButtonStyle(labelColor: Color.defaultText, backgroundColor: Color.clear, borderColor: Color.accentColor))
                
                
                Spacer()
            } //VSTACK
        } //ZSTACK
    }
}

//#Preview {
//    PhoneNumValidation(phoneNumber: .constant("01039446114"))
//        .environmentObject(RegisterViewModel())
//}
