//
//  CustomerStore.swift
//  DiningPick
//
//  Created by 한현민 on 10/11/23.
//

import Foundation

// MARK: 반환값 받는 부분에서 해당 값을 guard let 구문으로 넘겨 예외 처리
enum CustomerStoreError {
    case duplicate
    case doNotExist
    
    var description: String {
        switch self {
        case .duplicate:
            return "중복되는 항목이 존재합니다."
        case .doNotExist:
            return "대상을 찾을 수 없습니다."
        }
    }
}

class CustomerStore: ObservableObject {
    @Published var customer: Customer = .sampleData
    
    func fetchData() {
        // TO DO: Firebase 연동하여 가져오는 걸로 바꾸기
        customer = .sampleData
    }
    
    func didSubscriptionProvider(_ provider: Provider) -> Bool {
        customer.preferences.favoriteProviders.contains(provider.id)
    }
    
    func subscribeProvider(providerId: String) -> CustomerStoreError? {
        if customer.preferences.favoriteProviders.contains(providerId) {
            return .duplicate
        }
        // 매장 구독 추가하여 완료
        customer.preferences.favoriteProviders.append(providerId)
        return nil
    }
    
    func unsubscribeProvider(providerId: String) -> CustomerStoreError? {
        guard let index = customer.preferences.favoriteProviders.firstIndex(where: { id in
            providerId == id
        }) else {
            return .doNotExist
        }
        
        // 매장 구독 추가하여 완료
        customer.preferences.favoriteProviders.remove(at: index)
        return nil
    }
    
//    func updateData(_ customer: Customer) {
//        self.customer = customer
//    }

    func removeSubscribe(at offsets: IndexSet) {
        customer.preferences.favoriteProviders.remove(atOffsets: offsets)
        customer.preferences.subscribeMenuOfProviders.remove(atOffsets: offsets)
        customer.preferences.subscribeNoticeOfProviders.remove(atOffsets: offsets)
    }
    
    func onMove(from source: IndexSet, to destination: Int) {
        customer.preferences.favoriteProviders.move(fromOffsets: source, toOffset: destination)
    }
}
