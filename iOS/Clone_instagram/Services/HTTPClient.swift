//
//  HTTPClient.swift
//  Clone_instagram
//
//  Created by Taewon Yoon on 12/18/23.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case noData
    case decodingError
}

class HTTPClient {
    
    func register(registerModel: RegisterModel) {
        guard let url = URL(string: "") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(registerModel)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
        }.resume()
    }
    
    func getPosters(completion: @escaping (Result<[PostedModel]?, NetworkError>) -> Void) {
        guard let url = URL(string: "") else {
            return completion(.failure(.badURL))
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            
            guard let postedResponse = try? JSONDecoder().decode([PostedModel].self, from: data) else {
                return completion(.failure(.decodingError))
            }
            
            completion(.success(postedResponse))
        }
    }
}
