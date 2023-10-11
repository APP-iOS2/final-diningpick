//
//  SigninProviderView.swift
//  DiningPick
//
//  Created by 박재형 on 10/6/23.
//

import SwiftUI

struct FirstSigninProviderView: View {
    
    @StateObject private var signupVM: SignupViewModel = .init()
    
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("회원 정보를          (1 / 2)\n입력해 주세요.")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    VStack(spacing: 10) {
                        VStack(alignment: .leading) {
                            TextField("닉네임", text: $signupVM.nickName)
                                .keyboardType(.default)
                                .fullSizeTextField()
                            
                            HStack {
                                if !(signupVM.nickName.count > 3) {
                                    Image(systemName: "exclamationmark.triangle")
                                    Text("닉네임은 4자리 이상이여야 합니다.")
                                }
                            }.frame(minHeight: 20)
                                .font(.footnote)
                                .foregroundColor(.red)
                                .opacity(signupVM.nickName.isEmpty ? 0 : 1)
                        }
                        
                        VStack {
                            VStack(alignment: .leading) {
                                TextField("이메일 주소", text: $signupVM.email)
                                    .keyboardType(.emailAddress)
                                    .fullSizeTextField()
                                
                                HStack {
                                    if !signupVM.isEmailValid() {
                                        Image(systemName: "exclamationmark.triangle")
                                        Text("이메일 형식이 올바르지 않습니다.")
                                    }
                                }.frame(minHeight: 20)
                                    .font(.footnote)
                                    .foregroundColor(.red)
                                    .opacity(signupVM.email.isEmpty ? 0 : 1)
                            }
                        }
                        
                        VStack {
                            VStack(alignment: .leading) {
                                SecureField("비밀번호", text: $signupVM.password)
                                    .keyboardType(.asciiCapable)
                                    .fullSizeTextField()
                                
                                HStack {
                                    if !signupVM.isPasswordValid() {
                                        Image(systemName: "exclamationmark.triangle")
                                        Text("비밀번호 형식이 올바르지 않습니다.")
                                    }
                                }
                                .frame(minHeight: 20)
                                .font(.footnote)
                                .foregroundColor(.red)
                                .opacity(signupVM.password.isEmpty ? 0 : 1)
                            }
                        }
                        
                        VStack {
                            VStack(alignment: .leading) {
                                SecureField("비밀번호 확인", text: $signupVM.confirmPw)
                                    .keyboardType(.asciiCapable)
                                    .fullSizeTextField()
                                
                                HStack {
                                    if !signupVM.passwordsMatch() {
                                        Image(systemName: "exclamationmark.triangle")
                                        Text("비밀번호가 일치하지 않습니다.")
                                    }
                                }
                                        .frame(minHeight: 20)
                                        .font(.footnote)
                                        .foregroundColor(.red)
                                }
                            }
                        
                        NavigationLink {
                            // 두번째 점주 회원가입 뷰로
                            if signupVM.activateSubmitButton {
                                SecondSigninProviderView()
                            }
                            
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(style: .init(lineWidth: 0.4))
                                    .foregroundColor(signupVM.activateSubmitButton ? Color.themeBaseColor : Color.gray)
                                    .background(
                                        RoundedRectangle(cornerRadius: 8)
                                            .foregroundColor(signupVM.activateSubmitButton ? Color.themeBaseColor : Color.gray)
                                    )
                                    .frame(height: 60)
                                Text("다음으로")
                                    .foregroundColor(.black)
                            }
                        }
                        .toolbar {
                            ToolbarItem(placement: .topBarLeading) {
                                Button {
                                    dismiss()
                                } label: {
                                    HStack {
                                        Image(systemName: "chevron.backward")
                                        Text("유형 선택")
                                    }
                                }
                            }
                        }
                        Spacer()
                    }
                }
            }
            .navigationBarTitle("회원가입", displayMode: .inline)
            .navigationBarBackButtonHidden()
            .padding()
        }
    }
}

#Preview {
    FirstSigninProviderView()
}
