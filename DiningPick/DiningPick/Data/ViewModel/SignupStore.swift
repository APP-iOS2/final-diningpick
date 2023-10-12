//
//  SignupViewModel.swift
//  DiningPick
//
//  Created by 박재형 on 10/7/23.
//

import Foundation

//enum SigninValidError {
//    case nickName
//    case email
//    case password
//    case passwordMatch
//    
//    var errorMessage: String {
//        switch self {
//        case .nickName: return "닉네임은 3글자 이상이여야 합니다."
//        case .email: return "이메일 형식이 올바르지 않습니다."
//        case .password: return "비밀번호 형식이 올바르지 않습니다."
//        case .passwordMatch: return "비밀번호가 일치하지 않습니다."
//        }
//    }
//}


class SignupStore: ObservableObject {
    
    @Published var nickName: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    
    // MARK: - Validation Functions
    
    func passwordsMatch() -> Bool {
        password == confirmPassword
    }
    
    func isPasswordValid() -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@",
                                       "^(?=.*\\d).{4,8}$")
        return passwordTest.evaluate(with: password)
    }
    
    func isEmailValid() -> Bool {
        let emailTest = NSPredicate(format: "SELF MATCHES %@",
                                    "^\\w+@[a-zA-Z_]+?\\.[a-zA-Z]{2,3}$")
        return emailTest.evaluate(with: email)
    }
    
    var activateSubmitButton: Bool {
        if !passwordsMatch() ||
        !isPasswordValid() ||
            !isEmailValid() || !(nickName.count > 3) {
            return false
        }
        return true
    }
    
    func signUp() {
        // perform signup functions then clear fields
        email = ""
        password = ""
        confirmPassword = ""
    }
}

