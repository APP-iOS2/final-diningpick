//
//  ProviderStore.swift
//  DiningPick
//
//  Created by 한현민 on 10/11/23.
//

import Foundation

// Provider 화면에서 정보 수정하면 어떤 과정으로 providers에 적용할 수 있을까?
// 뷰에서 update 메서드 호출하도록 하는 방법이 제일 낫긴 하다.
// -> 뷰에서 currentProvider 받아서
class ProviderStore: ObservableObject {
    @Published var currentProvider: Provider = .emptyData
    @Published var providers: [Provider] = []
    
    func fetchData() {
        // TODO: 파베 연동 시 currentProvider, providers 업데이트
        currentProvider = .sampleSimpleData
        providers = Provider.sampleData
        
        debugPrint(currentProvider)
    }
    
    func addProvider(_ provider: Provider) {
        guard providers.contains(where: {
            $0.id == provider.id
        }) else {
            return
        }
        providers.append(provider)
    }
    
    func removeProvider(_ provider: Provider) -> Provider? {
        guard let index = providers.firstIndex(where: {
            $0.id == provider.id
        }) else {
            print("Failed to deletion: \(provider.id) object not exists")
            return nil
        }
        
        return providers.remove(at: index)
    }
    
    func updateProvider(_ provider: Provider) -> Provider? {
        guard let index = providers.firstIndex(where: {
            $0.id == provider.id
        }) else {
            print("Failed to update: object not exists")
            return nil
        }
        let old = providers[index]
        providers[index] = provider
        return old
    }
    
    // 고객이 구독한 id들의 목록을 매개변수로 받고,
    // 그에 해당하는 Provider 인스턴스들의 목록을 반환한다.
    func getProvidersByIDs(_ ids: [String]) -> [Provider] {
        var ret: [Provider] = []
        
        for id in ids {
            if let index = providers.firstIndex(where: { provider in
                provider.id == id
            }) {
                ret.append(providers[index])
            }
        }
        
        return ret
    }
    
    func getProvidersBySearchOption(_ option: SearchOption) -> [Provider] {
        providers.filter { provider in
            // Provider의 location, SearchOption의 location 모두
            // 동일한 Location 구조체 인스턴스.
            provider.location == option.location
        }
        .sorted(by: {
            option.sorting == .asc ? ($0 < $1) : ($0 > $1)
        })
    }
    
    // Customer가 구독한 id들의 배열을 받아, 구독한 매장의 게시글들을 찾아 반환한다.
    // 예시:
    // providerStore.getArticlesWrittenBySubscribedProviders(ids: customerStore.customer.preferences.favoriteProviders)
    func getArticlesWrittenBySubscribedProviders(ids: [String]) -> [Article] {
        var ret: [Article] = []
        
        // 구독한 id들을 가지고 구독한 provider 인스턴스들을 가져온다.
        let providers: [Provider] = getProvidersByIDs(ids)
        
        // 각 provider마다 article을 가져온다.
        for provider in providers {
            ret.append(contentsOf: provider.articles)
        }
        return ret
    }
    
    // Article의 providerId 값으로 provider를 가져온다.
    func getProviderByArticleProviderId(providerId: String) -> Provider {
        if let index = providers.firstIndex(where: { provider in
            provider.id == providerId
        }) {
            return providers[index]
        }
        return .emptyData
    }
    
    // NOTE: 좋아요 누르기 기능
    // 1. article의 providerId로 실제 provider 찾기
    // 2. 실제 provider 찾으면 여기서 실제 article 찾기
    // + 추가로, 좋아요 개수도 1 올린다. (해제할때는 1 감소)
    func setLikedArticle(article: Article) -> (Bool, Int) {
        guard let providerIndex = providers.firstIndex(where: { provider in
            provider.id == article.providerId
        }) else {
            print("failed to find \(article.providerId) provider in providers")
            return (false, -1)
        }
        
        guard let articleIndex = providers[providerIndex].articles.firstIndex(of: article) else {
            print("failed to find \(article.id) article in articles")
            return (false, -1)
        }
        
        providers[providerIndex].articles[articleIndex].isLiked.toggle()
        
        if providers[providerIndex].articles[articleIndex].isLiked {
            providers[providerIndex].articles[articleIndex].likes += 1
        } else {
            providers[providerIndex].articles[articleIndex].likes -= 1
        }
        
        return (providers[providerIndex].articles[articleIndex].isLiked, providers[providerIndex].articles[articleIndex].likes)
    }
    
    
}
