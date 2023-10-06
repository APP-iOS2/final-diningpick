//
//  Account.swift
//  DiningPick
//
//  Created by 한현민 on 10/5/23.
//

import Foundation

enum AccountType: String, Codable {
    case customer
    case provider
    case admin
}

struct Account: Codable {
    var id = UUID().uuidString
    var type: AccountType
    var email: String
    var password: String
    var nickname: String
}

extension Account {
    static let sampleCustomer: Account = .init(type: .customer, email: "customer@mail.com", password: "1234aa", nickname: "손님")
    static let sampleProvider: Account = .init(type: .provider, email: "provider@mail.com", password: "1234aa", nickname: "사장님")
    static let sampleAdmin: Account = .init(type: .admin, email: "admin@mail.com", password: "1234aa", nickname: "관리자")
}
