//
//  SettingView.swift
//  Clone_instagram
//
//  Created by Taewon Yoon on 1/20/24.
//

import SwiftUI

struct SettingPrivacyView: View {
    var body: some View {
        VStack {
            HStack {
                Text("내 계정")
                Spacer()
                Text("taewon")
            }
            HStack {
                Button {
                    
                } label: {
                    Text("로그아웃")
                        .foregroundStyle(.red)
                }
                Spacer()
            }

        }.padding()
    }
}

#Preview {
    SettingPrivacyView()
}
