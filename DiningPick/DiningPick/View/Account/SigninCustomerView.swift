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
    @StateObject private var signupVM: SignupStore = .init()
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("회원 정보를")
                    Text("입력해 주세요.")
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
                    
                    SecureField("비밀번호 확인", text: $signupVM.confirmPassword)
                        .keyboardType(.asciiCapable)
                        .fullSizeTextField()
                }
                
                HStack {
                    Image(systemName: "exclamationmark.triangle.fill")
                    Text("비밀번호는 영문, 숫자 조합으로 6자리 이상이어야 합니다.")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                NavigationLink {
                    // 회원가입 완료 뷰로
                } label: {
                    Text("회원가입")
                        .fullSizeButton(color: .mediumGray)
                }
                
                .padding(.top, 40)
                .disabled(!signupVM.activateSubmitButton)
                
                Spacer()
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
            .padding(.top, 70)
            .padding(.horizontal)
            .fullScreenCover(isPresented: $isPresentedCompleteScreen, content: {
                CompleteSigninView()
            })
            .navigationBarTitle("회원가입", displayMode: .inline)
            .navigationBarBackButtonHidden()
        }
    }
}
#Preview {
    SigninCustomerView()
}
