//
//  SigninCustomerView.swift
//  DiningPick
//
//  Created by 박재형 on 10/6/23.
//

import SwiftUI

struct SigninCustomerView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var nickName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var checkPassword: String = ""
    
    @State private var enabledSaveEmail: Bool = false
    @State private var enabledSavePassword: Bool = false

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("회원 정보를\n입력해 주세요.")
                }
                .font(.largeTitle)
                .fontWeight(.bold)
                
                VStack(spacing: 15) {
                    TextField("닉네임", text: $nickName)
                        .keyboardType(.emailAddress)
                        .fullSizeTextField()
                    
                    TextField("이메일 주소", text: $email)
                        .keyboardType(.emailAddress)
                        .fullSizeTextField()
                    
                    SecureField("비밀번호", text: $password)
                        .keyboardType(.asciiCapable)
                        .fullSizeTextField()
                    
                    SecureField("비밀번호 확인", text: $checkPassword)
                        .keyboardType(.asciiCapable)
                        .fullSizeTextField()
                }
                
                VStack(alignment: .leading, spacing: 100) {
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
            .navigationBarTitle("회원가입", displayMode: .inline)
            .navigationBarBackButtonHidden()
            .padding()
        }
    }
}

#Preview {
    SigninCustomerView()
}
