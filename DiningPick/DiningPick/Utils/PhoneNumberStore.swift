//
//  PhoneNumberStore.swift
//  HeadhunterApp
//
//  Created by 한현민 on 2023/08/24.
//

import Foundation

enum PhoneNumberPlace {
    case first
    case second
    case third
    
    var digitLimit: Int {
        switch self {
        case .first:
            return 3
        case .second, .third:
            return 4
        }
    }
}

// 전화번호 저장용
class PhoneNumberStore: ObservableObject {
    var limit: Int
    var place: PhoneNumberPlace
    
    @Published var value = ""
    
    init(place: PhoneNumberPlace) {
        self.place = place
        self.limit = place.digitLimit
        
        if !isValid() {
            return
        }
        
        let segments = value.components(separatedBy: "-")
        
        switch self.place {
        case .first:
            self.value = segments[0]
        case .second:
            self.value = segments[1]
        case .third:
            self.value = segments[2]
        }
    }
    
    private func isValid() -> Bool {
        let numberPlaces = 3 // 전화번호 자릿수
        let firstSegmentLengths = [3] // 전화번호 첫째 자릿수
        let secondSegmentLengths: [Int] = [3, 4] // 전화번호 둘째 자릿수
        let thirdSegmentLengths = [4] // 전화번호 셋째 자릿수
        
        if !value.contains("-") {
            return false
        }
        
        let segments: [String] = value.components(separatedBy: "-")
        
        if segments.count != numberPlaces {
            return false
        }
        
        switch place {
        case .first:
            return firstSegmentLengths.contains(segments[0].count)
            
        case .second:
            return secondSegmentLengths.contains(segments[1].count)
            
        case .third:
            return thirdSegmentLengths.contains(segments[2].count)
        }
    }
}
