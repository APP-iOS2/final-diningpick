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
                VStack(alignment: .leading) {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("회원 정보를")
                            Text("입력해 주세요.")
                        }
                        Spacer()
                        Text("(2 / 2)")
                    }
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom)
                    
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
                        ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(lineWidth: 1)
                                .foregroundStyle(Color.lightGray)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color(red: 249/255, green: 249/255, blue: 249/255))
                                    
                                )
                            TextField("   가게 소개(최소 10자리 이상을 입력하세요)", text: $checkPassword, axis: .vertical)
                                .keyboardType(.asciiCapable)
                                .frame(height: 100)
                        }
                        .frame(height: 150)
                    }
                    
                    NavigationLink {
                        // 회원가입 완료 뷰로
                    } label: {
                        Text("가입하기")
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
                    .padding(.top, 40)
                    
                    Spacer()
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
