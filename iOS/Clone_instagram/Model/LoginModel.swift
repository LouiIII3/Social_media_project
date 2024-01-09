//
//  LoginModel.swift
//  Clone_instagram
//
//  Created by Taewon Yoon on 12/18/23.
//

import Foundation
import SwiftUI

enum AuthenticationError: Error {
    case invalidCredentials
    case custom(errorMessage: String)
}

struct LoginModel: Codable {
    let userid: String
    let password: String
}

class LoginStatus: ObservableObject {
    @Published var isLogged: Bool?
}
