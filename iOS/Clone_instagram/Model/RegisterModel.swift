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

