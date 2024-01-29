//
//  SettingView.swift
//  Clone_instagram
//
//  Created by Taewon Yoon on 1/20/24.
//

import SwiftUI

struct SettingsPrivacyView: View {
    @EnvironmentObject var isLogged: LoginStatus
    
    var body: some View {

                List {
                    SettingMyAccountView()
                    SettingView(setting: settings2, header: "내 Instagram 사용 방식")
                    SettingView(setting: settings3, header: "내가 볼 수 있는 내용")
                    SettingView(setting: settings4, header: "내 콘텐츠를 볼 수 있는 사람")
                    SettingView(setting: settings5, header: "다른 사람이 나와 소통할 수 있는 방법")
                    SettingView(setting: settings6, header: "내 앱 및 미디어")
                    SettingView(setting: settings7, header: "가족")
                    SettingView(setting: settings8, header: "프로페셔널")
                    SettingView(setting: settings9, header: "내 주문 및 기부 캠페인")
                    SettingView(setting: settings10, header: "더 많은 정보 및 지원")
                    SettingView(setting: settings11, header: "로그인")
                }
                .background(.defaultBackground)
                .scrollContentBackground(.hidden)
        .navigationTitle("설정 및 개인정보")
    }
}

#Preview {
    SettingsPrivacyView()
}
