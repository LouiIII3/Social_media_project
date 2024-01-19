//
//  MainView.swift
//  Clone_instagram
//
//  Created by Taewon Yoon on 12/19/23.
//

import SwiftUI

struct MainView: View {
    @State private var pressed = false
    @State private var tabselection = 0
    @State private var path: [String] = []
    var body: some View {
        
        GeometryReader(content: { geometry in
            NavigationStack(path: $path) {
                
                TabView(selection: $tabselection) {
                    
                    PostedView()
                        .tabItem {
                            Image(systemName: "house.fill")
                        }.toolbarBackground(Color.tabBar, for: .tabBar)
                        .tag(1)
                    
                    SearchVideoView()
                        .tabItem {
                            Image(systemName: "magnifyingglass")
                        }.toolbarBackground(Color.tabBar, for: .tabBar)
                        .tag(2)
                    
                    
                    Text("")
                        .tabItem {
                            Image(systemName: "plus.square")
                        }.tag(3)
                    
                    ReelsView()
                        .tabItem {
                            Image(systemName: "play.rectangle")
                        }.toolbarBackground(Color.tabBar, for: .tabBar)
                        .tag(4)
                    
                    ProfileView()
                        .tabItem {
                            Image(systemName: "person.circle")
                        }.toolbarBackground(Color.tabBar, for: .tabBar)
                        .tag(5)
                    
                }
//                .overlay(alignment: .bottom, content: {
//                    Image(systemName: "plus.square")
//                })
                .navigationDestination(for: String.self) { _ in
                    SelectingImage(path: $path)
                }
                
                
                
            }
            .onChange(of: tabselection) {
                if tabselection == 3 {
                    tabselection = 1
                    print("추가:\(path.count)")
                    path.append("1")
                    print("추가후:\(path.count)")
                }
            }
            .onChange(of: path) {
                pressed.toggle()
            }
            .onAppear {
                Task {
                    let credential = try KeyChain.get()
                    print(credential)
                }
            } //NAVIGATION
        })
    }
}

#Preview {
    MainView()
}
