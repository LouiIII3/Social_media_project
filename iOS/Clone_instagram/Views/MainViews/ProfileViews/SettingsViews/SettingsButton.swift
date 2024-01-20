//
//  SettingsButton.swift
//  Clone_instagram
//
//  Created by Taewon Yoon on 1/20/24.
//

import SwiftUI

struct SettingsButton: View {
    var imageName: String?
    var buttonText: String?
    var placeholder: String?
    var body: some View {
        HStack {
            Image(systemName: imageName!)
            if let text = buttonText {
                VStack {
                    Text(buttonText!)
                    Text(placeholder!)
                }
            } else {
                Text(buttonText!)
            }
            
            Spacer()
        }.padding()
    }
}

#Preview {
    SettingsButton()
}
