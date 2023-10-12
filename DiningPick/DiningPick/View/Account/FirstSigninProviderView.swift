//
//  SigninProviderView.swift
//  DiningPick
//
//  Created by 박재형 on 10/6/23.
//

import SwiftUI

struct FirstSigninProviderView: View {
    
    @StateObject private var signupVM: SignupStore = .init()
    
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("회원 정보를")
                        Text("입력해 주세요.")
                    }
                    Spacer()
                    Text("(1 / 2)")
                }
                .font(.largeTitle)
                .fontWeight(.bold)
                    
                VStack(spacing: 15) {
                    TextField("닉네임", text: $signupVM.nickName)
                        .keyboardType(.emailAddress)
                        .fullSizeTextField()
                        
                    TextField("이메일 주소", text: $signupVM.email)
                        .keyboardType(.emailAddress)
                        .fullSizeTextField()
                        
                    SecureField("비밀번호", text: $signupVM.password)
                        .keyboardType(.asciiCapable)
                        .fullSizeTextField()
                        
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
                    // 두번째 점주 회원가입 뷰로
                    SecondSigninProviderView()
                } label: {
                    Text("다음으로")
                        .fullSizeButton(color: .mediumGray)
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
                .padding(.top, 40)
                
                Spacer()
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
