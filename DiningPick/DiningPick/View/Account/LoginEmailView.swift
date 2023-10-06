//
//  LoginEmailView.swift
//  DiningPick
//
//  Created by 한현민 on 10/5/23.
//

import SwiftUI

struct LoginEmailView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    
    @State private var enabledSaveEmail: Bool = false
    @State private var enabledSavePassword: Bool = false

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("이메일, 비밀번호를")
                    Text("입력해주세요.")
                }
                .font(.largeTitle)
                .fontWeight(.bold)
                
                VStack(spacing: 10) {
                    TextField("이메일", text: $email)
                        .keyboardType(.emailAddress)
                        .fullSizeTextField()
                    
                    SecureField("비밀번호", text: $password)
                        .keyboardType(.asciiCapable)
                        .fullSizeTextField()
                }
                
                HStack {
                    HStack(spacing: 8) {
                        Button {
                            enabledSaveEmail.toggle()
                        } label: {
                            if !enabledSaveEmail {
                                Image(systemName: "square")
                            } else {
                                Image(systemName: "checkmark.square.fill")
                            }
                        }
                        
                        Text("이메일 저장")
                    }
                    
                    HStack(spacing: 8) {
                        Button {
                            enabledSavePassword.toggle()
                        } label: {
                            if !enabledSavePassword {
                                Image(systemName: "square")
                            } else {
                                Image(systemName: "checkmark.square.fill")
                            }
                        }
                        
                        Text("자동 로그인")
                    }
                }
                
                VStack(spacing: 8) {
                    NavigationLink {
                        // TO DO: 계정 저장하는 ViewModel에 저장된 계정 타입에 따라 Customer, Provider, Admin 간 분기
//                        CustomerTabView()
                        // ProviderTabView()
                        // AdminView()
                    } label: {
                        Text("로그인")
                            .fullSizeButton(color: .themeAccentColor)
                    }
                    
                    
                    NavigationLink {
                        SigninAccountTypeSelectionView()
                    } label: {
                        Text("회원가입")
                            .fullSizeButton(color: .lightGray)
                    }
                }
                
                NavigationLink {
                    // TO DO: 비밀번호 찾기 뷰로 이동
                } label: {
                    Text("로그인에 문제가 생기셨나요?")
                        .foregroundStyle(Color.gray)
                }
            }
        }
        .padding()
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    LoginEmailView()
}
