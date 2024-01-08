//
//  ProfileView.swift
//  Clone_instagram
//
//  Created by Taewon Yoon on 12/19/23.
//

import SwiftUI

struct LineMenuView: View {
    let symbols = [["gearshape.fill", "설정 및 개인정보"], ["timer","내 활동"], ["clock.arrow.circlepath", "보관"], ["qrcode.viewfinder", "QR 코드"], ["bookmark.fill", "저장됨"], ["person.2", "관리 감독"], ["checkmark.seal", "MetaVerified"], ["list.star", "친한 친구"], ["star", "즐겨찾기"]]
    
    var body: some View {
        VStack {
            ForEach(symbols, id: \.self[0]) { symbol in
                HStack {
                    Image(systemName: symbol[0])
                        .foregroundColor(.blue)
                        .imageScale(.large)
                    Text(symbol[1])
                        .foregroundColor(Color.defaultText)
                    Spacer()
                }.padding(.horizontal)
                
                Divider()
            }
        }
    }
}

#Preview {
    LineMenuView()
}

struct PlusMenuView: View {
    let symbols = [["play.rectangle.fill", "릴스"], ["squareshape.split.3x3", "게시물"]]
    var body: some View {
            VStack {
                Text("만들기")
                    .padding(.top)
                
                Divider()
                
                ForEach(symbols, id: \.self[0]) { symbol in
                    HStack {
                        Image(systemName: symbol[0])
                            .foregroundColor(.blue)
                            .imageScale(.large)
                        Text(symbol[1])
                            .foregroundColor(Color.defaultText)
                        Spacer()
                    }.padding(.horizontal)
                    
                    Divider()
                }
                Spacer()
            }
            
    }
}

#Preview {
    PlusMenuView()
}

struct ProfileView: View {
    @State private var plusPressed = false
    @State private var linePressed = false
    var body: some View {
        NavigationStack {
            Text("프로필")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            plusPressed.toggle()
                        }, label: {
                            Image(systemName: "plus.app")
                                .foregroundStyle(.black)
                        })
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            linePressed.toggle()
                        }, label: {
                            Image(systemName: "line.3.horizontal")
                                .foregroundStyle(.black)
                        })
                    }
                }
                .sheet(isPresented: $linePressed, content: {
                    LineMenuView()
                        .presentationDetents([.fraction(0.65)])
                        .presentationDragIndicator(.visible)
                })
                .sheet(isPresented: $plusPressed, content: {
                    PlusMenuView()
                        .presentationDetents([.fraction(0.4)])
                        .presentationDragIndicator(.visible)
                })
        }
    }
}

#Preview {
    ProfileView()
}
