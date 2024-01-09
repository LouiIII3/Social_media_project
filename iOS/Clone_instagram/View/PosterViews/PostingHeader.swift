//
//  PostingTop.swift
//  Clone_instagram
//
//  Created by Taewon Yoon on 12/14/23.
//

import SwiftUI

struct PostingHeader: View {
    var body: some View {
        HStack {
            Image(systemName: "person.circle")
                .resizable()
                .frame(width: 30, height: 30)
            VStack {
                HStack {
                    Text("user_id")
                    Spacer()
                }
//                HStack {
//                    Text("user_id")
//                    Text("원본 사진")
//                    Spacer()
//                }
            }
            Spacer()
            
//            Button(action: {}, label: {
//                Text("팔로우")
//            })
//            .padding(.vertical, 3)
//            .padding(.horizontal, 10)
//            .border(Color.black)
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Image(systemName: "ellipsis")
            })
        }
        .padding(.horizontal, 10)
    }
}

#Preview {
    PostingHeader()
}
