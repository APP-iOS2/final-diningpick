//
//  CreateAccountChoice.swift
//  DiningPick
//
//  Created by 박재형 on 10/6/23.
//

import SwiftUI

struct CreateAccountChoice: View {
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("사용자 유형을\n선택해 주세요.")
                    .fontWeight(.bold)
                    .font(.system(size: 35))
                    // MARK: 고객 유형 회원가입 버튼
                Button(action: {
                    // 고객 회원가입 뷰로 이동
                    print("pressed")
                }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15.0)
                            .stroke(.black, lineWidth: 3.0)
                            .frame(width: 350, height: 250)
                        VStack {
                            Text("🙆🏻‍♀️")
                                .font(.system(size: 80))
                            Text("손님")
                                .foregroundStyle(.black)
                                .font(.system(size: 35))
                                .bold()
                        }
                    }
                })
                // MARK: 점주 유형 회원가입 버튼
                Button(action: {
                    // 점주 회원가입 뷰로 이동
                    print("pressed")
                }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15.0)
                            .stroke(.black, lineWidth: 3.0)
                            .frame(width: 350, height: 250)
                        VStack {
                            Text("🧑🏻‍🍳")
                                .font(.system(size: 80))
                            Text("사장님")
                                .foregroundStyle(.black)
                                .font(.system(size: 35))
                                .bold()
                        }
                    }
                })

            }
            .navigationBarTitle("회원가입", displayMode: .inline)
        }
    }
}

#Preview {
    CreateAccountChoice()
}
