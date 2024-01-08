//
//  MainView.swift
//  Clone_instagram
//
//  Created by Taewon Yoon on 12/15/23.
//

import SwiftUI

struct PostedView: View {
    var body: some View {
        
        ScrollView {
            InstagramHeader()

            VStack {
                PosterView()
                PosterView()
                PosterView()
                Spacer()
            }.scrollDisabled(false)
        }
    }
}

#Preview {
    PostedView()
}
