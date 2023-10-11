//
//  SigninCustomerView.swift
//  DiningPick
//
//  Created by 박재형 on 10/6/23.
//

import SwiftUI

struct SigninCustomerView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var isPresentedCompleteScreen: Bool = false
    @StateObject private var signupVM: SignupViewModel = .init()
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("회원 정보를\n입력해 주세요.")
                }
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
                    
                    VStack(alignment: .leading, spacing: 100) {
                        HStack {
                            Image(systemName: "exclamationmark.triangle.fill")
                            Text("비밀번호는 영문, 숫자 조합으로 8자리 이상이어야 합니다.")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                       Button(
                            action: {
                                isPresentedCompleteScreen.toggle()
                            }
                        , label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(style: .init(lineWidth: 0.4))
                                    .foregroundColor(signupVM.activateSubmitButton ? Color.themeBaseColor : Color.gray)
                                    .background(
                                        RoundedRectangle(cornerRadius: 8)
                                            .foregroundColor(signupVM.activateSubmitButton ? Color.themeBaseColor : Color.gray)
                                    )
                                    .frame(height: 60)
                                Text("회원가입")
                                    .foregroundColor(signupVM.activateSubmitButton ? Color.black : Color.black)
                            }
                        }).disabled(!signupVM.activateSubmitButton)
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
                .fullScreenCover(isPresented: $isPresentedCompleteScreen, content: {
                    CompleteSigninView()
                })
                .navigationBarTitle("회원가입", displayMode: .inline)
                .navigationBarBackButtonHidden()
                
            }
            .padding(.top, 70)
            .padding(.horizontal)
        }
    }
}
#Preview {
    SigninCustomerView()
}
