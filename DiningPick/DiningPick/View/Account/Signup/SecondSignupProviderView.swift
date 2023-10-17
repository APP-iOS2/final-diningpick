//
//  SecondSigninProviderView.swift
//  DiningPick
//
//  Created by 박재형 on 10/6/23.
//

import SwiftUI

struct SecondSignupProviderView: View {
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var signupVM: SignupStore
    
    @State private var isPresentedCompleteScreen: Bool = false

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
                    .font(.title)
                    .fontWeight(.bold)
                    
                    // Picker
                    VStack(spacing: 16) {
                        TextField("사업자 등록번호", text: $signupVM.businessRegisterNumber)
                            .keyboardType(.emailAddress)
                            .fullSizeTextField()
                        
                        TextField("가게 이름", text: $signupVM.providerName)
                            .keyboardType(.emailAddress)
                            .fullSizeTextField()
                        
                        // TODO: 연락처 검증하기
                        TextField("가게 연락처", text: $signupVM.providerPhoneNumber)
                            .keyboardType(.asciiCapable)
                            .fullSizeTextField()
                        
                        TextField("가게 주소", text: $signupVM.providerAddress)
                            .keyboardType(.asciiCapable)
                            .fullSizeTextField()
                        
                        TextField("가게 소개 (최소 10자리 이상을 입력하세요)", text: $signupVM.providerIntroduction, axis: .vertical)
                            .fullSizeTextField(size: .big)
                    }
                    .padding(.bottom)
                    
                    Button {
                        // TODO: firebase 저장
                        signupVM.saveSignupData()
                        isPresentedCompleteScreen.toggle()
                    } label: {
                        Text("회원가입")
                            .fullSizeButton(color: signupVM.validateInputData(type: .ProviderSecondSignup) ? .themeBaseColor : .mediumGray)
                    }
                    .disabled(!signupVM.validateInputData(type: .ProviderSecondSignup))
                    
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
                                Text("이전으로")
                            }
                        }
                    }
                }
                .fullScreenCover(isPresented: $isPresentedCompleteScreen) {
                    CompleteSignupView()
                }
            }
            .navigationBarTitle("회원가입", displayMode: .inline)
            .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    SecondSignupProviderView(signupVM: SignupStore())
}
