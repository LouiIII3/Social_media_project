//
//  ProfileView.swift
//  Clone_instagram
//
//  Created by Taewon Yoon on 12/19/23.
//

import SwiftUI

struct ProfileView: View {
    @State private var plusPressed = false
    @State private var linePressed = false
    @State private var path: [String] = []
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                ProfileNavigationBarView(plusPressed: $plusPressed, linePressed: $linePressed)
                ProfileHeaderView()
                ProfileControlButtonsView()
                ProfileMediaSelectionView()
                Spacer()
            }
            .sheet(isPresented: $linePressed, content: {
                LineMenuView(path: $path)
                    .presentationDetents([.fraction(0.7)])
                    .presentationDragIndicator(.visible)
            })
            .sheet(isPresented: $plusPressed, content: {
                PlusMenuView()
                    .presentationDetents([.fraction(0.4)])
                    .presentationDragIndicator(.visible)
            })
            .navigationDestination(for: String.self) { str in
                if str == "설정 및 개인정보" {
                    SettingsPrivacyView()
                }
            }
        }
    }
}

#Preview {
    ProfileView()
}
