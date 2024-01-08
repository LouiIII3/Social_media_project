//
//  RegisterViewModel.swift
//  Clone_instagram
//
//  Created by Taewon Yoon on 12/29/23.
//

import Foundation
import SwiftUI

class RegisterViewModel: ObservableObject {
    var model = RegisterModel.init(userid: "", password: "", birthdate: Date().description, fullName: "", key1: "0")
    
    func register(completion: @escaping (Bool) -> Void) async {
        let registerData = ["userid": model.userid, "password": model.password, "key1":model.key1, "birthdate": model.birthdate, "fullName":model.fullName,"profilePictureUrl": model.profilePictureUrl]
        print(model.birthdate)
        do {
            var request = URLRequest(url: Constants().registerPath!)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try JSONEncoder().encode(registerData)
            
            let configuration = URLSessionConfiguration.default
            configuration.httpAdditionalHeaders = ["Content-Type": "application/json"]
            
            let session = URLSession(configuration: configuration)
            
            let (data, _) = try await session.data(for: request)
            
            do {
//                let result = try JSONDecoder().decode(String.self, from: data)
                print(data.description)
                completion(true)
//                return result
            } catch let decodingError as DecodingError {
                switch decodingError {
                case .dataCorrupted(let context):
                    print("Data Corrupted: \(context)")
                case .keyNotFound(let key, let context):
                    print("Key Not Found: \(key), Context: \(context)")
                case .typeMismatch(let type, let context):
                    print("Type Mismatch: \(type), Context: \(context)")
                case .valueNotFound(let type, let context):
                    print("Value Not Found: \(type), Context: \(context)")
                @unknown default:
                    print("Unknown Decoding Error")
                }
            }
            throw NetworkError.decodingError
        } catch {
            print("에러 \(error)")
            completion(false)
//            completion(RegisterResponseDTD(error: true, reason: "네트워크에러"))
//            return RegisterResponseDTD(error: false, reason: error.localizedDescription)
        }
    }
}
