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
                                    Text(btn.placeholder!).foregroundStyle(.defaultText)
                                    Spacer()
                                }
                            }
                            Spacer()
                        }
                    }
                }
            }
        } header: {
            HStack {
                Text("내 계정").foregroundStyle(Color.defaultText)
                Spacer()
                Text("taewon").foregroundStyle(Color.accentColor)
            }.padding(.vertical, 3)
        }
    }
}

struct SettingView: View {
    var setting: Array<SettingViewModel>
    var header: String
    var body: some View {
        Section {
            ForEach(setting, id: \.self) { btn in
                NavigationLink(value: btn.buttonText) {
                    Button { } label: {
                        HStack {
                            Image(systemName: btn.imageName).foregroundStyle(.defaultText)
                            Text(btn.buttonText).foregroundStyle(.defaultText)
                            Spacer()
                        }
                    }
                }.padding(.vertical, 3)
            }
        } header: {
            HStack {
                Text(header).foregroundStyle(.gray)
                Spacer()
            }
        }
    }
}

#Preview {
    SettingView(setting: settings2, header: "내 Instagram 사용 방식")
}
