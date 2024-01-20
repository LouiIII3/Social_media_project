//
//  CommentView.swift
//  Clone_instagram
//
//  Created by Taewon Yoon on 12/15/23.
//

import SwiftUI

struct CommentView: View {
    
    @State private var comment = ""
    var body: some View {
        NavigationView(content: {
            VStack {
                
                Divider()
                
                HStack {
                    Image(systemName: "person.circle")
                        .resizable()
                        .frame(width: 40, height: 40)
                    VStack {
                        HStack {
                            Text("user_name")
                            Text("2주")
                                .font(.caption2)
                                .foregroundStyle(.gray)
                                
                            Spacer()
                        }
                        HStack {
                            Text("댓글")
                            Spacer()
                        }
                    }
                    
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 3)
                
                Spacer()
                
                HStack {
                    // 내 프로필 사진 넣기
                    Image(systemName: "person.circle")
                    TextField("댓글 달기...", text: $comment)
                        
                }.padding()
                
            }
            .toolbar(content: {
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Image(systemName: "paperplane")
                })

            })
            .navigationTitle("댓글")
            .navigationBarTitleDisplayMode(.inline)
        })
    }
}

#Preview {
    CommentView()
}
