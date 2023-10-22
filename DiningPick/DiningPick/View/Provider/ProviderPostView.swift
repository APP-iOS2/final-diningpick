//
//  ProviderPostView.swift
//  DiningPick
//
//  Created by 박재형 on 10/19/23.
//

import SwiftUI

struct ProviderPostView: View {
    @State private var enabledProviderButton: Bool = false
    @State private var enabledAdminButton: Bool = false

    @State private var openPhoto = false
    @State private var image = UIImage()

    var body: some View {
        NavigationStack {
            HStack {
                VStack(alignment: .leading, spacing: 20) {
                    Text("작성할 게시글 종류")
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
                            Text("공지사항")
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
                            Text("메뉴")
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
                        Text("탭하여 이미지를 추가해보세요.")
                        Image(uiImage: self.image)
                            .resizable()
                            .scaledToFit()
                    }
                    .foregroundColor(.black)
                    .opacity(0.3)
                    .feedBackCard(maxHeight: 100)
                }
                Button {
                    
                } label: {
                    VStack {
                        Image(systemName: "tablecells")
                            .font(.title)
                            .padding(.vertical, 10)
                        Text("탭하여 메뉴를 테이블로 작성해보세요.")
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
                .feedBackCard(maxHeight: 300)
                .navigationTitle("게시글 작성")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ProviderPostView()
}
