//
//  PostingView.swift
//  Clone_instagram
//
//  Created by Taewon Yoon on 12/27/23.
//

import SwiftUI

struct PostingView: View {
    
    @Binding var selected: UIImage
    @Environment(\.dismiss) var dismiss
    @State var textfield: String = ""
    @Binding var path: [String]
    
    var model = PostingViewModel()
    
    var body: some View {
        GeometryReader(content: { geometry in
            VStack {
                HStack {
                    Image(uiImage: selected)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width * 0.15, height: geometry.size.height * 0.15)
                    VStack {
                        TextField("문구를 입력하세요...", text: $textfield, axis: .vertical)
                            .multilineTextAlignment(.leading)
                            .lineLimit(nil)
                            .frame(height: geometry.size.width * 0.15)
                    }
                }.padding(.horizontal)
                Spacer()
            }
            .navigationTitle("새 개시물")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Image(systemName: "chevron.backward")
                    })
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        model.send(image: selected, text: textfield)// 이미지와 글 전송
                        path.removeAll() // 처음으로 돌아가기
                    }, label: {
                        Text("공유")
                            .foregroundStyle(Color.accentColor)
                            .bold()
                    })
                }
            }
        })
        
    }
}

#Preview {
    PostingView(selected: .constant(UIImage(named: "nopicture")!), path: .constant(["1"]))
}
