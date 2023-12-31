//
//  CustomerFeedBackView.swift
//  DiningPick
//
//  Created by 박재형 on 10/12/23.
//

import SwiftUI

struct CustomerFeedBackView: View {
    @State private var enabledProviderButton: Bool = false
    @State private var enabledAdminButton: Bool = false

    @State private var openPhoto = false
    @State private var image = UIImage()

    var body: some View {
        NavigationStack {
            HStack {
                VStack(alignment: .leading, spacing: 20) {
                    Text("건의할 대상")
                        .bold()

                    HStack(spacing: 30) {
                        HStack {
                            Button {
                                enabledProviderButton.toggle()
                            } label: {
                                if !enabledProviderButton {
                                    Image(systemName: "square")
                                } else {
                                    Image(systemName: "checkmark.square.fill")
                                }
                            }
                            Text("사장님")
                        }

                        HStack {
                            Button {
                                enabledAdminButton.toggle()
                            } label: {
                                if !enabledAdminButton {
                                    Image(systemName: "square")
                                } else {
                                    Image(systemName: "checkmark.square.fill")
                                }
                            }
                            Text("관리자")
                        }
                    }
                }
                .padding(.horizontal)
                Spacer()
            }
            .feedBackCard(maxHeight: 100)
            VStack {
                Button {
                    self.openPhoto = true
                } label: {
                    VStack {
                        Image(systemName: "photo")
                            .font(.title)
                            .padding(.vertical, 10)
                        Text("탭하여 이미지를 추가해보세요")
                        Image(uiImage: self.image)
                            .resizable()
                            .scaledToFit()
                    }
                    .foregroundColor(.black)
                    .opacity(0.3)
                    .feedBackCard(maxHeight: 150)
                }
            }
            Text("ss")
                .feedBackCard(maxHeight: 350)
            // 특정가게 탭하면 특정가게이름 나오도록 수정 예정
                .navigationTitle("가게이름")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    CustomerFeedBackView()
}
