//
//  ProfileMediaSelectionView.swift
//  Clone_instagram
//
//  Created by Taewon Yoon on 1/19/24.
//

import SwiftUI

struct ProfileMediaSelectionView: View {
    @State private var selectedView = 0

    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            Button(action:{
                selectedView = 0
            }){
                Image(systemName: selectedView == 0 ? "square.grid.3x3.fill" : "square.grid.3x3")
                    .padding(.vertical, 2)
                    .font(.system(size: 30))
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity)
            }

            Button(action:{
                selectedView = 1
            }){
                Image(systemName: selectedView == 1 ? "play.rectangle.fill" : "play.rectangle")
                    .padding(.vertical, 2)
                    .font(.system(size: 30))
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity)
            }
            Button(action:{
                selectedView = 2
            }){
                Image(systemName: selectedView == 2 ? "person.crop.circle.fill.badge.checkmark" : "person.crop.circle.badge.checkmark")
                    .padding(.vertical, 2)
                    .font(.system(size: 30))
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity)
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    ProfileMediaSelectionView()
}
