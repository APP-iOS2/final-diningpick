//
//  LoginEmailView.swift
//  DiningPick
//
//  Created by 한현민 on 10/5/23.
//

import SwiftUI

struct LoginEmailView: View {
    @EnvironmentObject var accountStore: AccountStore
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    @State private var enabledSaveEmail: Bool = false
    @State private var enabledSavePassword: Bool = false

    var body: some View {
        NavigationStack {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text("이메일, 비밀번호를")
                    Text("입력해주세요.")
                }
                .font(.largeTitle)
                .fontWeight(.bold)
                
                Spacer()
            }
            .padding(.top, 60)
            
            VStack(spacing: 10) {
                TextField("이메일", text: $email)
                    .keyboardType(.emailAddress)
                    .fullSizeTextField()
                
                SecureField("비밀번호", text: $password)
                    .keyboardType(.asciiCapable)
                    .fullSizeTextField()
            }
            .padding(.vertical, 10)
                
            HStack(spacing: 10) {
                Spacer()
                
                HStack(spacing: 6) {
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
                HStack(spacing: 6) {
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
                Spacer()
            VStack(spacing: 16) {
                NavigationLink {
                    // TO DO: 계정 저장하는 ViewModel에 저장된 계정 타입에 따라 Customer, Provider, Admin 간 분기
//                        CustomerTabView()
                    // ProviderTabView()
                    // AdminView()
                    
                    // 이메일, 비밀번호 받아서 검증
                    // 이메일은 UserDefaults로 저장
                    
                    // 자동로그인 체크되어 있으면 비밀번호, 자동로그인 여부까지 UserDefaults로 저장
                    // -> 비밀번호는 암호화를 해야하는가?
                    CustomerTabView()
                    
                } label: {
                    Text("로그인")
                        .fullSizeButton(color: .themeAccentColor)
                }
                    
                NavigationLink {
                    SigninAccountTypeSelectionView()
//                        .environmentObject(accountStore)
                } label: {
                    Text("회원가입")
                        .fullSizeButton(color: .lightGray)
                }
            }
            .padding(.vertical, 20)
        
            NavigationLink {
                // TO DO: 비밀번호 찾기 뷰로 이동
                FindPassword()
            } label: {
                Text("로그인에 문제가 생기셨나요?")
                    .foregroundStyle(Color.gray)
            }
            
            Spacer()
        }
        .navigationBarBackButtonHidden()
        .padding(.horizontal, 20)
    }
}

#Preview {
    LoginEmailView()
}
