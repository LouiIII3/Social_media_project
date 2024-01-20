//
//  SettingViewModel.swift
//  Clone_instagram
//
//  Created by Taewon Yoon on 1/20/24.
//

import Foundation

struct SettingViewModel: Hashable {
    let id = UUID()
    var imageName: String
    var buttonText: String
    var placeholder: String?
}

let settings1: Array<SettingViewModel> = [
    SettingViewModel(imageName: "person.crop.circle", buttonText: "계정 센터", placeholder: "비밀번호, 보안, 개인정보, 광고"),
]

let settings2: Array<SettingViewModel> = [
    SettingViewModel(imageName: "bell", buttonText: "알림"),
    SettingViewModel(imageName: "clock", buttonText: "이용시간"),
]

let settings3: Array<SettingViewModel> = [
    SettingViewModel(imageName: "star", buttonText: "즐겨찾기"),
    SettingViewModel(imageName: "bell.slash", buttonText: "업데이트를 보지 않도록 설정한 계정"),
    SettingViewModel(imageName: "play.rectangle.on.rectangle", buttonText: "추천 콘텐츠"),
    SettingViewModel(imageName: "heart.slash", buttonText: "좋아요 수 및 공유 수"),
]

let settings4: Array<SettingViewModel> = [
    SettingViewModel(imageName: "lock", buttonText: "계정 공개 범위"),
    SettingViewModel(imageName: "star.circle", buttonText: "친한 친구"),
    SettingViewModel(imageName: "nosign", buttonText: "차단된 계정"),
    SettingViewModel(imageName: "rectangle.on.rectangle.slash.circle", buttonText: "스토리 및 라이브 방송 숨기기"),
]

let settings5: Array<SettingViewModel> = [
    SettingViewModel(imageName: "ellipsis.message", buttonText: "메시지 및 스토리 답장"),
    SettingViewModel(imageName: "at.circle", buttonText: "태그 및 언급"),
    SettingViewModel(imageName: "bubble.right", buttonText: "댓글"),
    SettingViewModel(imageName: "arrow.2.squarepath", buttonText: "공유 및 리믹스"),
    SettingViewModel(imageName: "person.slash", buttonText: "제한된 계정"),
    SettingViewModel(imageName: "exclamationmark.bubble", buttonText: "제한된 반응"),
    SettingViewModel(imageName: "textformat.alt", buttonText: "숨겨진 단어"),
    SettingViewModel(imageName: "person.badge.plus", buttonText: "친구 팔로우 및 초대"),
]

let settings6: Array<SettingViewModel> = [
    SettingViewModel(imageName: "square.and.arrow.down", buttonText: "보관 및 다운로드"),
    SettingViewModel(imageName: "accessibility", buttonText: "접근성"),
    SettingViewModel(imageName: "character.textbox", buttonText: "언어"),
    SettingViewModel(imageName: "chart.bar.fill", buttonText: "미디어 품질"),
    SettingViewModel(imageName: "shield", buttonText: "웹사이트 권한"),
]

let settings7: Array<SettingViewModel> = [
    SettingViewModel(imageName: "person.2", buttonText: "관리 감독"),
]

let settings8: Array<SettingViewModel> = [
    SettingViewModel(imageName: "chart.bar.xaxis", buttonText: "계정 유형 및 도구"),
]

let settings9: Array<SettingViewModel> = [
    SettingViewModel(imageName: "list.dash.header.rectangle", buttonText: "주문 및 결제"),
]

let settings10: Array<SettingViewModel> = [
    SettingViewModel(imageName: "questionmark.circle", buttonText: "도움말"),
    SettingViewModel(imageName: "person", buttonText: "계정 상태"),
    SettingViewModel(imageName: "info.circle", buttonText: "정보")
]

//let settings: Array<SettingViewModel> = [
//    SettingViewModel(imageName: "chart.bar.xaxis", buttonText: "계정 유형 및 도구"),
//    SettingViewModel(imageName: "list.dash.header.rectangle", buttonText: "주문 및 결제"),
//    SettingViewModel(imageName: "questionmark.circle", buttonText: "도움말"),
//    SettingViewModel(imageName: "person", buttonText: "계정 상태"),
//    SettingViewModel(imageName: "info.circle", buttonText: "정보")
//]
