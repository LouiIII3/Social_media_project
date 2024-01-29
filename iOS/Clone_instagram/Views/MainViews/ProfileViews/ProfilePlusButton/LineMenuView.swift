//
//  LineMenuView.swift
//  Clone_instagram
//
//  Created by Taewon Yoon on 1/20/24.
//

import SwiftUI

struct LineMenuView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var path: [String]
    
    let symbols = [["gearshape.fill", "설정 및 개인정보"], ["character.magnify", "Treads"],["timer","내 활동"], ["clock.arrow.circlepath", "보관"], ["qrcode.viewfinder", "QR 코드"], ["bookmark.fill", "저장됨"], ["person.2", "관리 감독"], ["checkmark.seal", "MetaVerified"], ["list.star", "친한 친구"], ["star", "즐겨찾기"]]
    
    var body: some View {
        NavigationStack(path: $path) {
            GeometryReader(content: { geometry in
                VStack {
                    ForEach(symbols, id: \.self[0]) { symbol in
                        HStack {
                            NavigationLink(value: symbol[1]) {
                                Button(action: {
                                    path.append(symbol[1])
                                    dismiss()
                                }, label: {
                                    Image(systemName: symbol[0])
                                        .foregroundColor(.blue)
                                        .imageScale(.large)
                                    Text(symbol[1])
                                        .foregroundColor(Color.defaultText)
                                    Spacer()
                                })
                                .frame(width: geometry.size.width)
                            }
                            
                            Spacer()
                        }
                        
                        Divider()
                    }
                }.padding().padding([.top], 5)
            })
        }

    }
}

#Preview {
    LineMenuView(path: .constant([]))
}
