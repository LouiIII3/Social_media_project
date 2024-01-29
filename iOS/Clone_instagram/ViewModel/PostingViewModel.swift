//
//  PostingViewModel.swift
//  Clone_instagram
//
//  Created by Taewon Yoon on 1/29/24.
//

import Foundation
import SwiftUI

struct PostingViewModel {
    func send(image: UIImage, text: String) {
        let jpeg = image.jpegData(compressionQuality: 1.0)
        do {
            let data = try JSONEncoder().encode(PostingModel(image: jpeg!, text: text))

            var request = URLRequest(url: Constants().postingPath!)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let boundary = UUID().uuidString
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            
            var body = Data()
            
        } catch {
            
        }
    }
}
