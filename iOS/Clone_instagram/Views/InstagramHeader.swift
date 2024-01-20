//
//  InstagramHeader.swift
//  Clone_instagram
//
//  Created by Taewon Yoon on 12/14/23.
//

import SwiftUI

struct InstagramHeader: View {
    var body: some View {
        HStack {
            Text("Instagram")
            Spacer()
            Button(action: {}, label: {
                Image(systemName: "heart")
                    .padding()
            })
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Image(systemName: "location")
            })
        }.padding(.horizontal, 10)
    }
}

#Preview {
    InstagramHeader()
}
