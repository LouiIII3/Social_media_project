//
//  ProfilePicture.swift
//  Clone_instagram
//
//  Created by Taewon Yoon on 12/18/23.
//

import SwiftUI

struct ProfilePictureView: View {
    
    @EnvironmentObject var register: RegisterViewModel
    @State private var user = ""
    @State private var addPicture = false
    @Binding var path: [String]

    var buttonHeight: CGFloat = 40
//    var model = RegisterViewModel()
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.login, Color.loginColor2, Color.loginColor3]), startPoint: .topLeading, endPoint: .trailing)
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Text("프로필 사진 추가")
                        .font(.title3)
                        .bold()
                    Spacer()
                }.padding()
                
                HStack {
                    Text("친구들이 회원님을 알아볼 수 있도록 프로필 사진을 추가하세요. 프로필 사진은 모든 사람에게 공개됩니다.")
                        .font(.callout)
                    Spacer()
                }.padding(.horizontal)
                
                Image(systemName: "person.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(100)
                
                Spacer()
                
                Button(action: { addPicture.toggle() }, label: {
                    Text("사진 추가")
                        .frame(maxWidth: .infinity)
                        .frame(height: 40)
                })
                .buttonStyle(customButtonStyle(labelColor: Color.white, backgroundColor: Color.accentColor, borderColor: Color.accentColor))
                .navigationDestination(isPresented: $addPicture) {
                    PhoneNumView(path: $path)
                }
                
                Button(action: {
                    print("\(path.count)가 삭제하기 전")
                    Task {
                        await register.register { t in
                            
                        }
                        
                        path.removeLast(path.count)
                    }
                    print("\(path.count)가 삭제한 후")
                }, label: {
                    Text("건너뛰기")
                        .frame(maxWidth: .infinity)
                        .frame(height: 40)
                })
                .buttonStyle(customButtonStyle(labelColor: Color.defaultText, backgroundColor: Color.clear, borderColor: Color.accentColor))
                
                
            } //VSTACK
        } //ZSTACK

    }
}

//#Preview {
//    ProfilePictureView()
//        .environmentObject(RegisterViewModel())
//}
