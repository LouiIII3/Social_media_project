//
//  PostingImage.swift
//  Clone_instagram
//
//  Created by Taewon Yoon on 12/15/23.
//

import SwiftUI

struct PostingImage: View {
    @State var image: UIImage?
    
    var body: some View {
        Image("testimage")
            .resizable()
            .scaledToFit()
    }
}

#Preview {
    PostingImage()
}
