//
//  RegisterModel.swift
//  Clone_instagram
//
//  Created by Taewon Yoon on 12/18/23.
//

import Foundation
import SwiftUI
import Observation

struct RegisterModel: Codable {
    let userid: String
    let password: String
    let birthdate: String
    let fullName: String
    let key1: String?
    let profilePictureUrl = "data:image/jpeg;base64,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"
//    let verifycode: Int?
}
//

class RegisterNavigationPath: ObservableObject {
    @Published var path: [Int] = []
    
    func push(int: Int) {
        path.append(int)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeAll()
    }
}
