//
//  ProfileHeader.swift
//  Clone_instagram
//
//  Created by Taewon Yoon on 1/19/24.
//

import SwiftUI
struct ProfileHeaderView: View {
        
    var body: some View {
        HStack {
            Image("testimage")
                .resizable()
                .frame(width: 120, height: 120, alignment: .center)
                .cornerRadius(60)
                .clipped()
                .padding()
            Spacer()
            
            VStack {
                Text("205")
                    .font(Font.system(size: 16, weight: .bold))
                Text("Posts")
                    .font(Font.system(size: 14, weight: .medium))
            }
            Spacer()

            VStack {
                Text("364")
                    .font(Font.system(size: 16, weight: .bold))
                Text("Followers")
                    .font(Font.system(size: 14, weight: .medium))
            }
            Spacer()

            VStack {
                Text("358")
                    .font(Font.system(size: 16, weight: .bold))
                Text("Following")
                    .font(Font.system(size: 14, weight: .medium))
            }
            Spacer()
        }

        HStack {
            Text("윤태원")
                .font(.caption)
                .padding(.horizontal)
            Spacer()
        }
        
    }
}

#Preview {
    ProfileHeaderView()
}
