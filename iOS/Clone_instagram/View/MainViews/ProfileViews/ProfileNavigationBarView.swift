//
//  ProfileHeader.swift
//  Clone_instagram
//
//  Created by Taewon Yoon on 1/19/24.
//

import SwiftUI

struct ProfileNavigationBarView: View {
    @Binding var plusPressed: Bool
    @Binding var linePressed: Bool
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {}, label: {
                    Text("Raekwon")
                        .font(.largeTitle)
                        .fontDesign(.default)
                })
                Spacer()
                Button(action: {
                    plusPressed.toggle()
                }, label: {
                    Image(systemName: "plus.app")
                        .resizable()
                        .frame(width: 20, height: 20)
                        
                }).padding(.trailing, 15)
                Button(action: {
                    linePressed.toggle()
                }, label: {
                    Image(systemName: "line.horizontal.3")
                        .resizable()
                        .frame(width: 20, height: 15)
                })
            }
        }.padding([.top, .horizontal])
    }
}

#Preview {
    ProfileNavigationBarView(plusPressed: .constant(false), linePressed: .constant(false))
}
