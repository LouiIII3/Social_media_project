//
//  Clone_instagramApp.swift
//  Clone_instagram
//
//  Created by Taewon Yoon on 12/14/23.
//

import SwiftUI

@main
struct Clone_instagramApp: App {
    @Environment(\.scenePhase) var scenePhase
    @State private var credentials: Credentials?
    @StateObject var isLogged = LoginStatus()
    @StateObject var userinfo = RegisterViewModel()
    var loginmodel = LoginViewModel()
    
    //MARK: FUNC
    func getCredentials() -> Credentials? {
        do {
            print("확인하기")
            credentials = try KeyChain.get() // 키체인이 있는지 확인합니다.
            return credentials
        } catch KeychainError.notFound {
            print("존재하지 않는다")
            isLogged.isLogged = false
            return nil
        } catch {
            print("토큰 가져오기에러:\(error.localizedDescription)")
            isLogged.isLogged = false
            return nil
        }
    }
    
    // 비동기로 자동 로그인 시도
    private func attemptAutoLogin() {
        // 여기에서 자동 로그인 로직을 구현
        // 토큰이 유효하지 않은 상태라면 기존 로그인 정보로 재접속
        do {
            if try KeyChain.CheckToken() {
                loginmodel.Relogin(completion: { result in
                    if result { // 재로그인을 다시 시도했을때 성공할 경우
                        print("재로그인 성공 -> ContentView로 이동해야한다")
                        isLogged.isLogged = true
                    } else { // 재로그인을 실패했을때 로그인창으로 회원정보 재입력
                        print("재로그인 실패 -> 로그인뷰로 이동해야한다")
                        isLogged.isLogged = false
                    }
                })
            } else { isLogged.isLogged = false }
        } catch {
            print("에러 발생:\(error)")
        }
    }
    var body: some Scene {
        WindowGroup {
            if let views = isLogged.isLogged {
                if views {
                    MainView()
                } else {
                    LoginView()
                    
                }
            }
        }
        .environmentObject(isLogged)
        .environmentObject(userinfo)
        .onChange(of: scenePhase) {
            attemptAutoLogin()
//            do {
//                try KeyChain.delete()
//            } catch {
//                print(error.localizedDescription)
//            }
        }
    }
}
