//
//  CustomerFeedView.swift
//  DiningPick
//
//  Created by 한현민 on 10/6/23.
//

import SwiftUI

struct CustomerFeedView: View {
    @EnvironmentObject private var customerStore: CustomerStore
    @EnvironmentObject private var providerStore: ProviderStore
    
    @State private var isLiked: Bool = false
    @State private var articles: [Article] = []
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 24) {
                    // TODO: 피드 데이터 모델 만들고 뷰에 연결하기
                    ForEach(articles) { article in
                        // TODO: 카드뷰로 분리하기
                        NavigationLink {
                            CustomerStoreMainView(provider: providerStore.getProviderByArticleProviderId(providerId: article.providerId), navigatedFrom: .navigationLink)
                        } label: {
                            CustomerFeedCardView(article: article)
                        }
                        .buttonStyle(.plain)
                    }
                    .padding(.horizontal)
                }
            }
            .onAppear {
                articles = providerStore.getArticlesWrittenBySubscribedProviders(ids: customerStore.customer.preferences.favoriteProviders)
            }
            .refreshable {
                // TODO: 파베 연동시 fetchData() 넣기
                articles = providerStore.getArticlesWrittenBySubscribedProviders(ids: customerStore.customer.preferences.favoriteProviders)
            }
        }
    }
}

#Preview {
    CustomerFeedView()
        .environmentObject(CustomerStore())
        .environmentObject(ProviderStore())
}
