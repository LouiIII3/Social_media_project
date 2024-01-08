//
//  PhoneNumView.swift
//  Clone_instagram
//
//  Created by Taewon Yoon on 12/17/23.
//

import SwiftUI

struct PhoneNumView: View {
//    @Environment(RegisterViewModel.self) private var userinfo
    @EnvironmentObject var register: RegisterViewModel
    
    @State private var user = ""
    @State private var pressed = false
    @State private var phoneNumber = ""
    @Binding var path: [String]

    
    var buttonHeight: CGFloat = 40
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.login, Color.loginColor2, Color.loginColor3]), startPoint: .topLeading, endPoint: .trailing)
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Text("휴대폰 번호 입력")
                        .font(.title3)
                        .bold()
                    Spacer()
                }.padding()
                
                HStack {
                    Text("회원님에게 연락할 수 있는 휴대폰 번호를 입력하세요. 이 휴대폰 번호는 프로필에서 다른 사람에게 공개되지 않습니다.")
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
                    PhoneNumValidation(phoneNumber: $phoneNumber, path: $path)
                }
                
                Button(action: {}, label: {
                    Text("이메일 주소로 가입하기")
                        .frame(maxWidth: .infinity)
                        .frame(height: 40)
                })
                .buttonStyle(customButtonStyle(labelColor: Color.defaultText, backgroundColor: Color.clear, borderColor: Color.accentColor))
                
                
                Spacer()
            } //VSTACK
        } //ZSTACK
        //            .onAppear(perform: {
        //                print($userinfo)
        //            })
    }
}

//#Preview {
//    PhoneNumView()
//        .environmentObject(RegisterViewModel())
//}
