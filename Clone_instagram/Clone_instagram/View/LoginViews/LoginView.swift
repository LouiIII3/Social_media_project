//
//  LoginView.swift
//  Clone_instagram
//
//  Created by Taewon Yoon on 12/15/23.
//

import SwiftUI

struct customTextFieldModifier: ViewModifier {
    var roundedCorners: CGFloat
    var textColor: Color
    
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.white)
            .foregroundStyle(textColor)
            .clipShape(RoundedRectangle(cornerRadius: roundedCorners))
            .font(.system(size: 18))
            .shadow(radius: 1)
    }
}

struct customButtonStyle: ButtonStyle {
    var labelColor: Color
    var backgroundColor: Color
    var borderColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        let pressed = configuration.isPressed
        return configuration.label
            .foregroundStyle(labelColor)
            .contentShape(Capsule()) // 버튼이 클릭될 프레임 선택
            .background(Capsule().fill(backgroundColor))
            .scaleEffect(pressed ? 0.98 : 1.0)
            .animation(.easeIn(duration: 0.2), value: pressed)
            .opacity(pressed ? 0.9 : 1)
            .overlay(
                Capsule()
                    .stroke(borderColor, lineWidth: 1.0)
                    .scaleEffect(pressed ? 0.98 : 1.0)
                    .animation(.easeIn(duration: 0.2), value: pressed)
                    .opacity(pressed ? 0.9 : 1)
            )
            .padding([.horizontal])
            .padding(.top, 5)
        
    }
}


struct LoginView: View {
    
    @EnvironmentObject var isLogged: LoginStatus
    @EnvironmentObject var register: RegisterViewModel
    @State private var id: String = ""
    @State private var password: String = ""
    @State private var pressed = false
    @State private var path: [String] = []
    @State private var errorPressed = false
    
    var model = LoginViewModel()
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.login, Color.loginColor2, Color.loginColor3]), startPoint: .topLeading, endPoint: .trailing)
                    .ignoresSafeArea()
                VStack {
                    
                    Spacer()
                    
                    Image("instagram-icon")
                        .resizable()
                        .frame(width: 100, height: 100)
                    
                    Spacer()
                    
                    TextField(text: $id, prompt: Text("사용자 이름, 이메일 주소 또는 휴대폰 번호").foregroundStyle(.gray)) {}.modifier(customTextFieldModifier(roundedCorners: 15, textColor: .black))
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal)
                    
                    SecureField(text: $password, prompt: Text("비밀번호").foregroundStyle(.gray)) {}
                        .modifier(customTextFieldModifier(roundedCorners: 15, textColor: .black))
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal)
                    
                    Button(action: { 
                        model.login { result in
                            if result {
                                errorPressed.toggle()
                            } else {
                                isLogged.isLogged = true
                            }
                        }
                         }, label: {
                        Text("로그인")
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 40)
                    })
                    .buttonStyle(customButtonStyle(labelColor: Color.white, backgroundColor: Color.accentColor, borderColor: Color.accentColor))
                    
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Text("비밀번호를 잊으셨나요?")
                            .foregroundStyle(Color.black)
                            .font(.callout)
                    })
                    .padding(.top, 5)
                    
                    Spacer(minLength: 220)
                    
                    //MARK: 계정 만드는 파트
                    
                    NavigationLink(value: "LoginView") {
                        Text("새 계정 만들기")
                            .frame(maxWidth: .infinity)
                            .frame(height: 40)
                            .contentShape(Capsule()) // 버튼이 클릭될 프레임 선택
                            .background(Capsule().fill(Color.clear))
                            .scaleEffect(pressed ? 0.98 : 1.0)
                            .animation(.easeIn(duration: 0.2), value: pressed)
                            .opacity(pressed ? 0.9 : 1)
                            .overlay(
                                Capsule()
                                    .stroke(Color.accentColor, lineWidth: 1.0)
                                    .scaleEffect(pressed ? 0.98 : 1.0)
                                    .animation(.easeIn(duration: 0.2), value: pressed)
                                    .opacity(pressed ? 0.9 : 1)
                            )
                            .onTapGesture(perform: {
                                path.append("LoginView")
                            })
                    }.padding(.horizontal)
                    
                    Text("made by taewon")
                        .padding(.top)
                } //VSTACK
                .navigationDestination(for: String.self) {_ in 
                    NameInputView(path: $path)
                }
                .alert("로그인 실패", isPresented: $errorPressed) {
                    Button("CANCLE", role: .cancel) {}
                    Button("OK", role: .destructive) {}
                } message: {
                    Text("다시 로그인하세요")
                }
            } //ZSTACK
        } //NavigationStack
    }
    
}

#Preview {
    LoginView()
        .environmentObject(RegisterViewModel())
}
