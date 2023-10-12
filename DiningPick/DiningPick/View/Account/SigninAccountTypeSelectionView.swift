//
//  CreateAccountChoice.swift
//  DiningPick
//
//  Created by 박재형 on 10/6/23.
//

import SwiftUI

struct SigninAccountTypeSelectionView: View {
    @Environment(\.dismiss) private var dismiss

    @EnvironmentObject var accountStore: AccountStore

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                VStack(spacing: 8) {
                    Text("사용자 유형을")
                    Text("선택해 주세요.")
                }
                .font(.largeTitle)
                .fontWeight(.bold)

                // MARK: 고객 유형 회원가입 버튼

                NavigationLink {
                    SigninCustomerView()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15.0)
                            .stroke(.black, lineWidth: 3.0)
//                            .frame(minHeight: 20)
                        VStack {
                            Text("🙆🏻‍♀️")
                            Text("손님")
                                .foregroundStyle(.black)
                                .bold()
                        }
                        .font(.largeTitle)
                    }
                }

                // MARK: 점주 유형 회원가입 버튼

                NavigationLink {
                    FirstSigninProviderView()
                    // 점주 회원가입 뷰로 이동
//                    ExampleView()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15.0)
                            .stroke(.black, lineWidth: 3.0)
//                            .frame(minHeight: 20)
                        VStack {
                            Text("🧑🏻‍🍳")
                            Text("사장님")
                                .foregroundStyle(.black)
                                .bold()
                        }
                        .font(.largeTitle)
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
    SigninAccountTypeSelectionView()
}
