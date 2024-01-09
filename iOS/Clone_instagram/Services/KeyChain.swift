//
//  KeyChain.swift
//  team_project
//
//  Created by Taewon Yoon on 11/16/23.
//

// {
//"sub": "1111111111",
//"iat": 1700232055,
//"exp": 1700232175
//}
import Foundation
import SwiftUI

struct Credentials: Codable {
    var username: String
    var psssword: String
    var token: String
}

enum KeychainError: Error {
    case noPassword
    case unexpectedPasswordData
    case unhandledError(status: OSStatus)
    case notFound
    case alreadyExist
}

class KeyChain {
    
    static let shared = KeyChain() // 싱글톤
    static let server = "http://lsproject.shop/login"
    @EnvironmentObject var isLogged: LoginStatus
    
    static func save(credentials: Credentials) throws {
        let encoder = JSONEncoder()
        print("저장할 유저이름:\(credentials.username), 유저토큰:\(credentials.token), 유저비밀번호:\(credentials.psssword)")
        let data = try encoder.encode(credentials)
        
        let query: [String: Any] = [kSecClass as String: kSecClassInternetPassword, // keychain Item Class
                                    kSecAttrServer as String: server, // 접속하려는 서버 정보
                                    kSecAttrAccount as String: credentials.username, // 계정 ID 정보
                                    kSecValueData as String: data]
        let status = SecItemAdd(query as CFDictionary, nil) // 키체인에 항목 추가하기
        if status == errSecSuccess {
            print("Successfully added to keychain.")
            
        } else {
            if let error: String = SecCopyErrorMessageString(status, nil) as String? {
                print(error, status.hashValue)
            }
        }
        
    }
    
    static func get() throws -> Credentials {
        let query: [String: Any] = [kSecClass as String: kSecClassInternetPassword,
                                    kSecMatchLimit as String: kSecMatchLimitOne,
                                    kSecAttrServer as String: server,
                                    kSecReturnAttributes as String: true, // username 포함
                                    kSecReturnData as String: true] // token 포함
        print("keychain에서 가져오는거 시작")
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        print("값 있는지 확인")
        guard status != errSecItemNotFound else { throw KeychainError.notFound }

        print("값은 있다고 하는데..")
        guard status == errSecSuccess else { throw
            KeychainError.unhandledError(status: status)
        }
        let decoder = JSONDecoder()
        guard let existingItem = item as? [String : Any] else {
            throw KeychainError.unexpectedPasswordData
        }
        let decoded = try decoder.decode(Credentials.self, from: (existingItem[kSecValueData as String] as? Data)!)
        print("불러오기 성공 password: \(decoded.psssword), account: \(decoded.username), token: \(decoded.token)")
        return Credentials(username: decoded.username, psssword: decoded.psssword, token: decoded.token)
    }
    
    // 통신할때마다 계속 사용될 토큰 유효한지 확인하는 코드, 유효하지 않으면 다시 받아온다.
    static func CheckToken() throws -> Bool{
        let query: [String: Any] = [kSecClass as String: kSecClassInternetPassword,
                                    kSecMatchLimit as String: kSecMatchLimitOne,
                                    kSecAttrServer as String: server,
                                    kSecReturnAttributes as String: true, // username 포함
                                    kSecReturnData as String: true] // token 포함
        print("keychain에서 가져오는거 시작")
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        print("값 있는지 확인")
        guard status != errSecItemNotFound else { return false }
        return true
    }
    
    static func update(credentials: Credentials) throws {
        let query: [String: Any] = [kSecClass as String: kSecClassInternetPassword,
                                    kSecAttrServer as String: server]
        
        print("업데이트할 유저이름:\(credentials.username), 유저토큰:\(credentials.token), 유저비밀번호:\(credentials.psssword)")
        let encoder = JSONEncoder()
        let data = try encoder.encode(credentials)
        let attributes: [String: Any] = [kSecAttrAccount as String: credentials.username,
                                         kSecValueData as String: data]
        
        let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
        guard status != errSecItemNotFound else { throw KeychainError.noPassword }
        guard status == errSecSuccess else { throw KeychainError.unhandledError(status: status) }
    }
    
    static func delete() throws {
        print("삭제하기")
        let query: [String: Any] = [kSecClass as String: kSecClassInternetPassword,
                                    kSecAttrServer as String: server]
        let status = SecItemDelete(query as CFDictionary)
        print("삭제하기2")
        if status == errSecSuccess {
            print("Successfully deleted the keychain.")
            
        } else {
            if let error: String = SecCopyErrorMessageString(status, nil) as String? {
                print(error)
            }
        }
        
        guard status == errSecSuccess || status == errSecItemNotFound else { throw KeychainError.unhandledError(status: status) }
    }
}
