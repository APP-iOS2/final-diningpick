//
//  ProviderStore.swift
//  DiningPick
//
//  Created by 한현민 on 10/11/23.
//

import Foundation

class ProviderStore: ObservableObject {
    @Published var providers: [Provider] = Provider.sampleData
    
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
}
