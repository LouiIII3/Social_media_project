//
//  RegisterViewModel.swift
//  Clone_instagram
//
//  Created by Taewon Yoon on 12/29/23.
//

import Foundation
import SwiftUI

class RegisterViewModel: ObservableObject {
    var model = RegisterModel.init(userid: "", password: "", birthdate: Date().description, nickname: "", key1: "0")
    
    func register(completion: @escaping (Bool, String?) -> Void) async {
        let registerData = ["userid": model.userid, "password": model.password, "key1":model.key1, "birthdate": model.birthdate, "nickname":model.nickname,"profilePictureUrl": model.profilePictureUrl]
        print(model)
        do {
            var request = URLRequest(url: Constants().registerPath!)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try JSONEncoder().encode(registerData)
            
            let configuration = URLSessionConfiguration.default
            configuration.httpAdditionalHeaders = ["Content-Type": "application/json"]
            
            let session = URLSession(configuration: configuration)
            
            let (data, _) = try await session.data(for: request)
            print(data)
            guard let token = String(data: data, encoding: .utf8) else {
                completion(false, "String이 아닌 값을 받았다")
                print("토큰 무효")
                return
            }
            if token == "만료된 키입니다." {
                completion(false, "만료된 키입니다.")
            } else if token == "이미 있는 ID 입니다." {
                completion(false, "이미 있는 ID 입니다.")
            } else {
                let credentials = Credentials(username: model.userid, psssword: model.password, token: token)
                if try await KeyChain.CheckToken() {
                    try await KeyChain.update(credentials: credentials)
                } else {
                    try await KeyChain.save(credentials: credentials)
                }
                completion(true, nil)
            }

        } catch {
            print("에러 \(error)")
            completion(false, "네트워크 에러")
        }
    }
}
