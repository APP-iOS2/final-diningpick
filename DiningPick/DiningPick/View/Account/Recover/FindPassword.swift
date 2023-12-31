//
//  FindPassword.swift
//  DiningPick
//
//  Created by 박재형 on 10/5/23.
//

import SwiftUI

struct FindPassword: View {
    @State private var emailAdress: String = ""
    @State private var checkCode: String = ""
    
    @Environment(\.dismiss) private var dismiss
    
//    @State private var enabledSaveEmail: Bool = false
//    @State private var enabledSavePassword: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("이메일 인증을")
                    Text("완료해 주세요.")
                }
                .font(.title)
                .fontWeight(.bold)
                
                VStack(alignment: .leading, spacing: 15) {
                    TextField("이메일 주소", text: $emailAdress)
                        .keyboardType(.emailAddress)
                        .fullSizeTextField(size: .regular)
                    
                    HStack(spacing: 20) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(lineWidth: 1)
                                .foregroundStyle(Color.lightGray)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color(red: 249/255, green: 249/255, blue: 249/255))
                                )
                            
                            TextField("인증코드", text: $checkCode)
                                .keyboardType(.asciiCapable)
                                .fullSizeTextField()
                        }
                        .frame(width: 250, height: 60)
                        
                        Button(
                            action: {
                                // 인증코드 발송
                            },
                            label: {
                                Text("발송")
                                    .keyboardType(.asciiCapable)
                                    .fullSizeButton(color: .accentColor)
                            }
                        )
                        .frame(minWidth: 50)
                        .buttonStyle(.plain)
                    }
                }
                
                VStack(alignment: .leading) {
                    Button(
                        action: {
                            print("ddddds")
                        },
                        label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(style: .init(lineWidth: 0.4))
                                    .foregroundColor((self.emailAdress.count > 0 && self.checkCode.count > 0) ? Color.themeBaseColor : Color.gray)
                                    .background(
                                        RoundedRectangle(cornerRadius: 8)
                                            .foregroundColor((self.emailAdress.count > 0 && self.checkCode.count > 0) ? Color.themeBaseColor : Color.gray)
                                    )
                                    .frame(height: 60)
                                    
                                Text("인증 완료")
                                    .foregroundStyle(Color.black)
                                    .font(.system(size: 24))
                                    .fontWeight(.bold)
                            }
                        }
                    )
                    .padding(.top, 50)
                    .disabled(self.emailAdress.count > 0 && self.checkCode.count > 0 ? false : true)
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button {
                                dismiss()
                            } label: {
                                HStack {
                                    Image(systemName: "chevron.backward")
                                    Text("로그인")
                                }
                            }
                        }
                    }
                    Spacer()
                }
            }
            .navigationBarTitle("비밀번호 찾기", displayMode: .inline)
            .navigationBarBackButtonHidden()
            .padding()
        }
    }
}

#Preview {
    FindPassword()
}

// foregroundColor((self.emailAdress.count > 0 && self.checkCode.count > 0) ? Color.themeBaseColor : Color.blue)
