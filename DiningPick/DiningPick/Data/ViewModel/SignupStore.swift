//
//  SignupViewModel.swift
//  DiningPick
//
//  Created by 박재형 on 10/7/23.
//

import Foundation

// enum SigninValidError {
//    case nickName
//    case email
//    case password
//    case passwordMatch
//
//    var errorMessage: String {
//        switch self {
//        case .nickName: return "닉네임은 3글자 이상이어야 합니다."
//        case .email: return "이메일 형식이 올바르지 않습니다."
//        case .password: return "비밀번호 형식이 올바르지 않습니다."
//        case .passwordMatch: return "비밀번호가 일치하지 않습니다."
//        }
//    }
// }

// 회원가입 진행단계마다 요구하는 항목이 달라, 진행단계를 구분하는 기능이 필요
// 매개변수로 받기
enum SignupPhase {
    case CustomerSignup
    case ProviderFirstSignup
    case ProviderSecondSignup
}

// 입력값 검증 & 서버에 가입정보 저장
class SignupStore: ObservableObject {
    @Published var nickname: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    
    @Published var businessRegisterNumber: String = ""
    @Published var providerName: String = ""
    // TODO: 연락처 검증하기
    @Published var providerPhoneNumber: String = ""
    @Published var providerAddress: String = ""
    @Published var providerIntroduction: String = ""
    
    // MARK: - Validation Functions
    
    // 발생할 수 있는 문제점: 호출할 때 SignupPhase의 열거형 값에 따라 검증하는 항목을 다르게 한다.
    // 이때 실제로 검증할 항목에 대한 enum 값이 아닌 다른 enum 값을 포함하여 호출하는 경우
    // 의도치 않은 검증을 할 수 있다.
    func validateInputData(type: SignupPhase) -> Bool {
        switch type {
        case .CustomerSignup:
            return validateCustomerSignupPhase()
        case .ProviderFirstSignup:
            return validateProviderFirstSignupPhase()
        case .ProviderSecondSignup:
            return validateProviderSecondSignupPhase()
        }
    }
    
    // 고객 회원가입 입력값 검증
    // 닉네임, 이메일 주소, 비밀번호, 비밀번호 확인
    private func validateCustomerSignupPhase() -> Bool {
        validateNickname() && validateEmail() && validatePassword() && isEqualToPassword()
    }
    
    // 점주 회원가입 1차 입력값 검증
    // 닉네임, 이메일 주소, 비밀번호, 비밀번호 확인
    private func validateProviderFirstSignupPhase() -> Bool {
        validateNickname() && validateEmail() && validatePassword() && isEqualToPassword()
    }
    
    // 점주 회원가입 2차 입력값 검증
    // 사업자 등록번호, 가게 이름, 연락처, 가게 주소, 가게 소개
    private func validateProviderSecondSignupPhase() -> Bool {
        validateBusinessRegisterNumber() && validateProviderName() && validateProviderPhoneNumber() && validateProviderAddress() && validateProviderIntroduction()
    }
    
    // ======= 고객, 점주 1차 =======
    func validateNickname() -> Bool {
        nickname.count > 3
    }
    
    func validateEmail() -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@",
                                    "^\\w+@[a-zA-Z_]+?\\.[a-zA-Z]{2,3}$")
        return predicate.evaluate(with: email)
    }
    
    func validatePassword() -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@",
                                    "^(?=.*\\d).{4,8}$")
        return predicate.evaluate(with: password)
    }
    
    func isEqualToPassword() -> Bool {
        password == confirmPassword
    }
    
    // ======= 점주 2차 =======
    func validateBusinessRegisterNumber() -> Bool {
        return true
    }
    
    func validateProviderName() -> Bool {
        return true
    }
    
    func validateProviderPhoneNumber() -> Bool {
        return true
    }
    
    func validateProviderAddress() -> Bool {
        return true
    }
    
    func validateProviderIntroduction() -> Bool {
        providerIntroduction.count >= 10
    }
    
    func saveSignupData() {
        // perform signup functions then clear fields
//        email = ""
//        password = ""
//        confirmPassword = ""
    }
}
