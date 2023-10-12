//
//  SearchCondition.swift
//  DiningPick
//
//  Created by 한현민 on 10/12/23.
//

import Foundation

struct SearchOption {
    var province: Province
    var city: City
    var category: Category
    var sorting: Sorting
}

struct Province {
    var picked: String
    static let pickable: [String] = ["서울", "경기", "인천", "대전", "세종", "충남", "충북", "부산", "대구", "경북", "경남", "광주", "전북", "전남"]
}

struct City {
    var picked: String
    static let pickable: [String: [String]] = [
        "서울": ["강남", "서초", "마포", "용산"],
        "경기": ["수원", "용인", "성남", "고양", "김포", "파주"]
    ]
}

struct Category {
    var picked: String
    static let pickable: [String] = ["한식", "중식", "양식", "카페"]
}

enum Sorting {
    case asc, desc
    
    var description: String {
        switch self {
        case .asc:
            return "오름차순"
        case .desc:
            return "내림차순"
        }
    }
    
    static let pickable: [Sorting] = [.asc, .desc]
}

extension SearchOption {
    static let sampleData: SearchOption = .init(province: .init(picked: Province.pickable[0]), city: .init(picked: City.pickable["서울"]![0]), category: .init(picked: Category.pickable[0]), sorting: .asc)
}
