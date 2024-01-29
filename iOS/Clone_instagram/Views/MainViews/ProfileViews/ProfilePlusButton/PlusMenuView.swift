//
//  PlusMenuView.swift
//  Clone_instagram
//
//  Created by Taewon Yoon on 1/20/24.
//

import SwiftUI

struct PlusMenuView: View {
    let symbols = [["play.rectangle.fill", "릴스"], ["squareshape.split.3x3", "게시물"]]
    var body: some View {
        Text("만들기")
            .padding(.top)
        GeometryReader { geometry in
            VStack {
                
                Divider()
                VStack {
                    Button(action: {}, label: {
                        HStack {
                            Image(systemName: symbols[0][0])
                                .foregroundColor(.blue)
                                .imageScale(.large)
                            Text(symbols[0][1])
                                .foregroundColor(Color.defaultText)
                            Spacer()
                        }
                    })
                    .frame(width: geometry.size.width)
                    .padding(.leading)
                    
                    Divider()
                    
                    Button(action: {}, label: {
                        HStack {
                            Image(systemName: symbols[1][0])
                                .foregroundColor(.blue)
                                .imageScale(.large)
                            Text(symbols[1][1])
                                .foregroundColor(Color.defaultText)
                            Spacer()
                        }.frame(width: geometry.size.width)
                    }).padding(.leading)
                }
                
                Spacer()
            }.padding(.top)
            
            
        }
    }
}

#Preview {
    PlusMenuView()
}
