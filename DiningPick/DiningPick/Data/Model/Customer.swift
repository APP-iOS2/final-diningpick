//
//  Customer.swift
//  DiningPick
//
//  Created by 한현민 on 10/11/23.
//

import Foundation

struct Customer: Identifiable, Codable {
    var id = UUID().uuidString
    var preferences: CustomerPreference
}

struct CustomerPreference: Codable {
    var favoriteProviders: [String]             // 선호하는 가게들의 uuidstring 배열
    var subscribeNoticeOfProviders: [String]    // 공지사항 구독한 가게들의 uuidstring 배열
    var subscribeMenuOfProviders: [String]      // 메뉴 구독한 가게들의 uuidstring 배열
}

extension Customer {
    // Provider의 id를 가지고 참조
    static let sampleData: Customer = .init(preferences: .init(favoriteProviders: ["1A23D4F", "3BA3D4F"], subscribeNoticeOfProviders: ["1A23D4F"], subscribeMenuOfProviders: ["1A23D4F"]))
}
