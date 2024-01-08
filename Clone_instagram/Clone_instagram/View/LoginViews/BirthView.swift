//
//  BirthView.swift
//  Clone_instagram
//
//  Created by Taewon Yoon on 12/16/23.
//

import SwiftUI


let dateformat: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "YYYY년 M월 d일"
    return formatter
}()

struct BirthView: View {
    
    @EnvironmentObject var register: RegisterViewModel
    @Binding var path: [String]

    @State private var pressed = false
    @State private var currentDate = Date()
    @State private var date = false
    
    var buttonHeight: CGFloat = 40

    
    // 텍스트 필드에 들어갈 텍스트를 DateFormatter 변환
    private func dateFormat(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-mm-dd"
        
        return formatter.string(from: date)
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.login, Color.loginColor2, Color.loginColor3]), startPoint: .topLeading, endPoint: .trailing)
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Text("생년월일 입력")
                        .font(.title3)
                        .bold()
                    Spacer()
                }.padding()
                
                HStack {
                    Text("비즈니스, 반려동물 또는 기타 목적으로 이 계정을 만드는 경우에도 회원님의 실제 생년월일을 사용하세요. 이 생년월일 정보는 회원님이 공유하지 않는 한 다른 사람에게 공개되지 않습니다.")
                        .font(.callout)
                    Spacer()
                }.padding(.horizontal)
                
                
                VStack {
                    DatePicker(selection: $currentDate, in: ...Date(), displayedComponents: .date) {
                        Text("date")
                    }.datePickerStyle(.wheel)
                }.labelsHidden()
                
                Button(action: { pressed.toggle() }, label: {
                    Text("다음")
                        .frame(maxWidth: .infinity)
                        .frame(height: 40)
                })
                .buttonStyle(customButtonStyle(labelColor: Color.white, backgroundColor: Color.accentColor, borderColor: Color.accentColor))
                .navigationDestination(isPresented: $pressed) {
                    UserNameView(path: $path)
                }
                .onChange(of: currentDate) {
//                    register.model.birthdate = dateFormat(date: currentDate)
                }
                
                
                Spacer()
            } //VSTACK
        } //ZSTACK
        
    }
}

//#Preview {
//    BirthView()
//        .environmentObject(RegisterViewModel())
//}


extension Binding {
    func toUnwrapped<T>(defaultValue: T) -> Binding<T> where Value == Optional<T>  {
        Binding<T>(get: { self.wrappedValue ?? defaultValue }, set: { self.wrappedValue = $0 })
    }
}
