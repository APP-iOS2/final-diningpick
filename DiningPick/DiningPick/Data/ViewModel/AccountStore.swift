//
//  AccountStore.swift
//  DiningPick
//
//  Created by 한현민 on 10/5/23.
//

import Foundation

class AccountStore: ObservableObject {
    @Published var account: Account = .sampleCustomer
    
    func updateEmail(_ email: String) {
        account.email = email
    }
    
    func updatePassword(_ password: String) {
        account.password = password
    }
    
    func updateNickname(_ nickname: String) {
        account.nickname = nickname
    }
}
