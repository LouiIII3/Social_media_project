//
//  ProfileControlButtonsView.swift
//  Clone_instagram
//
//  Created by Taewon Yoon on 1/19/24.
//

import SwiftUI

struct ProfileControlButtonsView: View {
    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            Button(action:{

            }){
                Text("Edit Profile")
                    .font(Font.system(size: 13, weight: .medium))
                    .padding(.vertical, 9)
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity)
                    .overlay(
                        RoundedRectangle(cornerRadius: 3)
                            .stroke(Color.primary, lineWidth: 0.2)
                    )
            }
            .padding(.leading)

            Button(action:{

            }){
                Text("Saved")
                    .font(Font.system(size: 13, weight: .medium))
                    .padding(.vertical, 9)
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity)
                    .overlay(
                        RoundedRectangle(cornerRadius: 3)
                            .stroke(Color.primary, lineWidth: 0.2)
                    )
            }
            .padding(.trailing)
        }
    }
}

#Preview {
    ProfileControlButtonsView()
}
