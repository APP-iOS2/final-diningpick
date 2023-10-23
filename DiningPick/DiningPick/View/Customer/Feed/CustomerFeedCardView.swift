//
//  CustomerFeedCardView.swift
//  DiningPick
//
//  Created by 한현민 on 10/23/23.
//

import SwiftUI

struct CustomerFeedCardView: View {
    // 다크모드 활성화 여부
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject private var providerStore: ProviderStore
    
    var article: Article
    
    @State private var isLiked: Bool = false
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                // 프로필 이미지
                Image(systemName: "person.crop.circle.fill")
                    .font(.system(size: 40))
                
                VStack(alignment: .leading, spacing: 4) {
                    Spacer()
                    HStack {
                        Text(article.providerName)
                            .bold()
                        
                        Spacer()
                        
                        Button {
                            isLiked = providerStore.setLikedArticle(article: article)
                        } label: {
                            HStack(spacing: 4) {
                                if !isLiked {
                                    Image(systemName: "heart")
                                        .foregroundColor(.red)
                                } else {
                                    Image(systemName: "heart.fill")
                                        .foregroundColor(.red)
                                }
                                Text("24")
                                    .foregroundStyle(colorScheme == .light ? Color.black : Color.white)
                            }
                        }
                    }
                    
                    Text("2023년 10월 5일 오후 3:17")
                        .padding(.vertical, 2)
                    Spacer()
                }
            }
            
            if let menus = article.menus {
                ZStack {
                    RoundedRectangle(cornerRadius: 0.0)
                        // border와 foregroundStyle은 따로 적용
                        // border -> 테두리
                        // foregroundStyle -> 바탕색
                        .border(.accent, width: 4)
                        .foregroundStyle(.background)
                    
                    //                        Divider()
                    VStack(spacing: 6) {
                        ForEach(menus, id: \.self) { menu in
                            VStack {
                                Text(menu)
                                    .padding(4)
                                Divider()
                            }
                        }
                    }
                    .padding()
                }
            }
            
            if let content = article.content {
                HStack {
                    Text(content)
                    Spacer()
                }
            }
            
            Divider()
        }
    }
}

#Preview {
    CustomerFeedCardView(article: .sampleData[0])
}
