//
//  SelectingImageTab.swift
//  Clone_instagram
//
//  Created by Taewon Yoon on 1/6/24.
//

import SwiftUI

struct SelectingImageTab: View {
    @Binding var path: [String]
    var body: some View {
        NavigationStack(path: $path) {
            Text("abc")
        }
    }
}

#Preview {
    SelectingImageTab(path: .constant([]))
}
