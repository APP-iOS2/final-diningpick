//
//  SignupAccountTypeSelectionView.swift.swift
//  DiningPick
//
//  Created by 박재형 on 10/6/23.
//

import SwiftUI

struct SignupAccountTypeSelectionView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var accountStore: AccountStore
    
    @StateObject var signupVM: SignupStore = .init()

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("사용자 유형을")
                    Text("선택해 주세요.")
                }
                .font(.title)
                .fontWeight(.bold)

                Spacer()

                NavigationLink {
                    SignupCustomerView(signupVM: signupVM)
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15.0)
                            .stroke(.gray, lineWidth: 2.0)
                        VStack {
                            Text("🙆🏻‍♀️")
                            Text("손님")
                                .foregroundStyle(.black)
                                .bold()
                        }
                        .font(.title)
                    }
                }

                // MARK: 점주 유형 회원가입 버튼

                NavigationLink {
                    FirstSignupProviderView(signupVM: signupVM)
                    // 점주 회원가입 뷰로 이동
//                    ExampleView()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15.0)
                            .stroke(.gray, lineWidth: 2.0)
                        VStack {
                            Text("🧑🏻‍🍳")
                            Text("사장님")
                                .foregroundStyle(.black)
                                .bold()
                        }
                        .font(.title)
                    }
                }
            }
            .padding()
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
            .navigationBarBackButtonHidden()
            .navigationBarTitle("회원가입", displayMode: .inline)
        }
    }
}

#Preview {
    SignupAccountTypeSelectionView()
}
