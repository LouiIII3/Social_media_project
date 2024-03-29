//
//  SettingView.swift
//  Clone_instagram
//
//  Created by Taewon Yoon on 1/20/24.
//

import SwiftUI

struct SettingMyAccountView: View {
    var body: some View {
        Section {
            ForEach(settings1, id: \.self) { btn in
                NavigationLink(value: btn.buttonText) {
                    Button {
                        
                    } label: {
                        HStack {
                            Image(systemName: btn.imageName).foregroundStyle(.defaultText)
                            VStack {
                                HStack {
                                    Text(btn.buttonText).foregroundStyle(.defaultText)
                                    Spacer()
                                }
                                HStack {
                                    Text(btn.placeholder!)
                                        .foregroundStyle(.gray)
                                        .font(.caption)
                                    Spacer()
                                }
                            }
                            Spacer()
                        }
                    }
                }
            }
            
            HStack {
                Text("Meta 테크놀로지에 연결된 환경 및 계정 설정을 관리해보세요.")
                    .padding(.top, 3)
                    .font(.caption)
                Spacer()
            }
        } header: {
            HStack {
                Text("내 계정").foregroundStyle(Color.gray).font(.caption).bold()
                Spacer()
                Text("taewon").foregroundStyle(Color.accentColor)
            }.padding(.vertical)
        }
        .listRowSeparator(.hidden)
    }
}

struct SettingView: View {
    @EnvironmentObject var isLogged: LoginStatus

    var setting: Array<SettingViewModel>?
    var header: String
    
    func logout() {
        do {
            try KeyChain.delete()
            isLogged.isLogged = false
            print("isLogged 수정됌: \(isLogged.isLogged)")
        } catch {
            print("키체인 삭제 에러: \(error.localizedDescription)")
            return
        }
    }
    
    func buttonColor(text: String) -> Color {
        if text == "계정 추가" {
            return Color.accentColor
        } else if text == "로그아웃" {
            return Color.red
        } else {
            return Color.defaultText
        }
    }
    var body: some View {
            Section {
                if let settings = setting {
                    ForEach(settings, id: \.self) { btn in
                        NavigationLink(value: btn.buttonText) {
                            Button { 
                                if btn.buttonText == "로그인" {
                                    logout()
                                }
                            } label: {
                                HStack {
                                    if !btn.imageName.isEmpty {
                                        Image(systemName: btn.imageName).foregroundStyle(.defaultText)
                                    }
                                    Text(btn.buttonText).foregroundStyle(buttonColor(text: btn.buttonText))
                                    Spacer()
                                }
                            }
                        }.padding(.vertical, 3)
                    }
                }
            } header: {
                HStack {
                    Text(header).foregroundStyle(.gray)
                    Spacer()
                }
            }
            .listRowSeparator(.hidden)
    }
}

#Preview {
    SettingView(setting: settings2, header: "내 Instagram 사용 방식")
}
