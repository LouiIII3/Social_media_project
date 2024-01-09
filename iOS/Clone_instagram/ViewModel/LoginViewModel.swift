//
//  LoginViewModel.swift
//  Clone_instagram
//
//  Created by Taewon Yoon on 12/30/23.
//

import Foundation
import SwiftUI

class LoginViewModel {
    
    @Published var isLoggedIn = false
    @EnvironmentObject var isLogged: LoginStatus
    var model = LoginModel(userid: "", password: "")
    
    let httpClient = HTTPClient()
    // 여기서 토큰 체크하고 갱신한다
    func login(userid: String, password: String, completion: @escaping (Bool) -> Void) {
        let loginData = ["userid": userid, "password": password]
        print(loginData)
        var request = URLRequest(url: Constants().loginPath!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(loginData)

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(false)
                print("데이터 무효")
                return
            }
            
            guard let token = String(data: data, encoding: .utf8) else {
                completion(false)
                print("토큰 무효")
                return
            }
            if token == "로그인 실패" {
                completion(false)
                print("로그인 실패하였음")
                return
            }
            print("토큰값: \(token)")
            let credentials = Credentials(username: userid, psssword: password, token: token)
            
            Task {
                if try KeyChain.CheckToken() {
                    try KeyChain.update(credentials: credentials)
                    completion(true)
                } else {
                    try KeyChain.save(credentials: credentials)
                    completion(true)
                }
            }
            print("33333")
            
        }.resume()
    }
    func Relogin(completion: @escaping (Bool) -> Void) {
        do {
            let credentials = try KeyChain.get()
            let loginData = ["userid": credentials.username, "password": credentials.psssword]
            var request = URLRequest(url: Constants().loginPath!)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try? JSONEncoder().encode(loginData)
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    completion(false)
                    print("데이터 무효")
                    return
                }
                
                guard let token = String(data: data, encoding: .utf8) else {
                    completion(false)
                    print("토큰 무효")
                    return
                }
                print("토큰값: \(token)")
                let credentials = Credentials(username: credentials.username, psssword: credentials.psssword, token: token)
                Task {
                    do {
                        if try KeyChain.CheckToken() {
                            try KeyChain.update(credentials: credentials)
                            completion(true)
                        } else {
                            try KeyChain.save(credentials: credentials)
                            completion(true)
                        }
                    } catch {
                        print("에러:\(error)")
                        completion(false)
                    }
                }
                
            }.resume()
        } catch {
            
        }

        

    }
    
}
