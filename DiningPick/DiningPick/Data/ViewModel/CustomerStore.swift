//
//  CustomerStore.swift
//  DiningPick
//
//  Created by 한현민 on 10/11/23.
//

import Foundation

class CustomerStore: ObservableObject {
    @Published var customer: Customer = .sampleData
    
    func fetchData() {
        // TO DO: Firebase 연동하여 가져오는 걸로 바꾸기
        customer = .sampleData
    }

    func removeSubscribe(at offsets: IndexSet) {
        customer.preferences.favoriteProviders.remove(atOffsets: offsets)
        customer.preferences.subscribeMenuOfProviders.remove(atOffsets: offsets)
        customer.preferences.subscribeNoticeOfProviders.remove(atOffsets: offsets)
    }
    
    func onMove(from source: IndexSet, to destination: Int) {
        customer.preferences.favoriteProviders.move(fromOffsets: source, toOffset: destination)
    }
}
