//
//  CompleteSignupView.swift
//  DiningPick
//
//  Created by 박재형 on 10/6/23.
//

import SwiftUI

struct CompleteSignupView: View {
    var body: some View {
        NavigationStack {
            Text("🎉")
                .font(.system(size: 100))
                .padding(3)
            VStack(spacing: 8) {
                Text("환영합니다!")
                    .font(.system(size: 30, design: .rounded))
                .bold()
                
                Text("회원가입이 완료되었습니다.")
                    .font(.system(size: 20))
                    .padding(5)
            }
            
            
            NavigationLink {
                LoginEmailView()
            }
        label: {
            Text("로그인 화면으로 돌아가기")
                .fullSizeButton(color: .themeBaseColor)
        }
        .padding(20)
        }
    }
}

#Preview {
    CompleteSignupView()
}
