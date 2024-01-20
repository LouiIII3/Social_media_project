//
//  InstagramFooter.swift
//  Clone_instagram
//
//  Created by Taewon Yoon on 12/14/23.
//

import SwiftUI

struct PostringFooter: View {
    
    @State private var isPressed = false

    var body: some View {
        VStack {
            //MARK: 좋아요, 하트, 전송, 저장하기
            HStack {
                Button(action: {}, label: {
                    Image(systemName: "heart")
                }).padding(.horizontal, 5)
                
                Button(action: {}, label: {
                    Image(systemName: "message")
                }).padding(.trailing, 5)
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Image(systemName: "paperplane")
                })
                
                Spacer()
                
                Button(action: {}, label: {
                    Image(systemName: "bookmark")
                        .resizable()
                        .frame(width: 15, height: 15)
                }).padding(.trailing, 5)
                
            }.padding(.horizontal, 10)
            
            HStack {
                Image(systemName: "person.circle")
                Text("happyytw님 외 24명이 좋아합니다")
                    .font(.caption)
                Spacer()
            }
            .padding(.horizontal, 15)
            .padding(.top, 3)
            
            //MARK: 댓글
            HStack {
                Text("사람들이 입력할 댓글")
                    .font(.caption)
                Spacer()
            }
            .onTapGesture {
                isPressed.toggle()
            }
            .padding(.horizontal, 15)
            .sheet(isPresented: $isPressed, content: {
                CommentView()
                    .presentationDetents([.fraction(0.7), .large]) // fraction:커스텀 높이
                    .presentationDragIndicator(.visible) // 드래그할 수 있는게 표시된다.
                    .presentationBackgroundInteraction(.enabled(upThrough: .medium)) // 중간 위로부터는 시트 뒤에 있는 배경과 상호작용이 가능해진다.
            })
            
            
            HStack {
                Text("2023년 12월 14일")
                    .font(.system(.caption2))
                    .foregroundStyle(.gray)
                Spacer()
            }
            .padding(.top, 1)
            .padding(.horizontal, 15)

        }
        .padding(.top, 3)
    }
}

#Preview {
    PostringFooter()
}
