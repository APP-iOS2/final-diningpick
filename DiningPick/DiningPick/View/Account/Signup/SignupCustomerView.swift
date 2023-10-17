//
//  SignupCustomerView.swift
//  DiningPick
//
//  Created by 박재형 on 10/6/23.
//

import SwiftUI

struct SignupCustomerView: View {
    @Environment(\.dismiss) private var dismiss

    @ObservedObject var signupVM: SignupStore
    
    @State private var isPresentedCompleteScreen: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("회원 정보를")
                    Text("입력해 주세요.")
                }
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom)
                
                VStack(spacing: 12) {
                    VStack(alignment: .leading) {
                        TextField("닉네임", text: $signupVM.nickname)
                            .keyboardType(.default)
                            .fullSizeTextField()
                        
                        HStack {
                            Image(systemName: "exclamationmark.triangle")
                            Text("닉네임은 4자리 이상이어야 합니다.")
                        }
                        .font(.footnote)
                        .foregroundColor(.red)
                        .opacity(signupVM.nickname.count > 3 || signupVM.nickname.isEmpty ? 0 : 1)
                    }
                    
                    VStack(alignment: .leading) {
                        TextField("이메일 주소", text: $signupVM.email)
                            .keyboardType(.emailAddress)
                            .fullSizeTextField()
                            
                        HStack {
                            Image(systemName: "exclamationmark.triangle")
                            Text("이메일 형식이 올바르지 않습니다.")
                        }
                        .font(.footnote)
                        .foregroundColor(.red)
                        .opacity(signupVM.validateEmail() || signupVM.email.isEmpty ? 0 : 1)
                    }
                    
                    VStack(alignment: .leading) {
                        SecureField("비밀번호", text: $signupVM.password)
                            .keyboardType(.asciiCapable)
                            .fullSizeTextField()
                            
                        HStack {
                            Image(systemName: "exclamationmark.triangle")
                            Text("비밀번호 형식이 올바르지 않습니다.")
                        }
                        .frame(minHeight: 20)
                        .font(.footnote)
                        .foregroundColor(.red)
                        .opacity(signupVM.validatePassword() || signupVM.password.isEmpty ? 0 : 1)
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
                .padding(.bottom)
                
                Button {
                    // 회원가입 완료 뷰로
                    signupVM.saveSignupData()
                    isPresentedCompleteScreen.toggle()
                } label: {
                    Text("회원가입")
                        .fullSizeButton(color: signupVM.validateInputData(type: .CustomerSignup) ? .themeBaseColor : .mediumGray)
                }
                .disabled(!signupVM.validateInputData(type: .CustomerSignup))
                
                Spacer()
            }
            .padding(.top, Dimensions.textFieldsTopPadding)
            .padding(.bottom, Dimensions.textFieldsBottomPadding)
            .padding(.horizontal, Dimensions.textFieldHorizontalPadding)
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
            .fullScreenCover(isPresented: $isPresentedCompleteScreen, content: {
                CompleteSignupView()
            })
            .navigationBarTitle("회원가입", displayMode: .inline)
            .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    SignupCustomerView(signupVM: SignupStore())
}
