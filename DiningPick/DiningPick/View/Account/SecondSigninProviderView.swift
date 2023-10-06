//
//  SecondSigninProviderView.swift
//  DiningPick
//
//  Created by 박재형 on 10/6/23.
//

import SwiftUI

struct SecondSigninProviderView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var nickName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var checkPassword: String = ""
    
    @State private var enabledSaveEmail: Bool = false
    @State private var enabledSavePassword: Bool = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 25) {
                    Text("회원 정보를          (2 / 2)\n입력해 주세요.")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text("지역 및 분류")
                        .fontWeight(.bold)
                    // Picker
                    VStack(spacing: 15) {
                        TextField("사업자 등록번호", text: $nickName)
                            .keyboardType(.emailAddress)
                            .fullSizeTextField()
                        
                        TextField("가게 이름", text: $email)
                            .keyboardType(.emailAddress)
                            .fullSizeTextField()
                        
                        TextField("가게 연락처", text: $password)
                            .keyboardType(.asciiCapable)
                            .fullSizeTextField()
                        
                        TextField("가게 주소", text: $checkPassword)
                            .keyboardType(.asciiCapable)
                            .fullSizeTextField()
                        
                        TextField("가게 소개\n(최소 10자리 이상을 입력하세요)", text: $checkPassword)
                            .keyboardType(.asciiCapable)
                            .fullSizeTextField()
                    }
                    
                    VStack(alignment: .leading, spacing: 65) {
                        HStack {
                            Image(systemName: "exclamationmark.triangle.fill")
                            Text("비밀번호는 영문, 숫자 조합으로 6자리 이상이어야 합니다.")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        NavigationLink {
                            // 회원가입 완료 뷰로
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
                                        Text("전 단계")
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
}

#Preview {
    SecondSigninProviderView()
}
