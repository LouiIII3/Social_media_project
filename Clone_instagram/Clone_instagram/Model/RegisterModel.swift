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
    var userid: String
    var password: String
    var birthdate: String
    var nickname: String
    var key1: String?
    let profilePictureUrl = "data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/"
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
