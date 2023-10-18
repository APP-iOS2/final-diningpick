//
//  SearchCondition.swift
//  DiningPick
//
//  Created by 한현민 on 10/12/23.
//

// TO DO: 각 pickable 내용 채워넣기

import Foundation

struct SearchOption {
    var location: Location
    var sorting: Sorting
}

// Provider가 갖는 것
struct Location: Codable {
    var province: Province
    var city: City
    var category: Category
}

struct Province: Codable {
    var picked: String
    static let pickable: [String] = ["서울", "경기", "인천", "대전", "세종", "충남", "충북", "부산", "대구", "경북", "경남", "광주", "전북", "전남", "제주"]
}

struct City: Codable {
    var picked: String
    static let pickable: [String: [String]] = [
        "서울": ["강남구", "강동구", "강북구", "강서구", "관악구", "광진구", "구로구", "금천구", "노원구", "도봉구", "동대문구", "동작구", "마포구", "서대문구", "서초구", "성동구", "성북구", "송파구", "양천구", "영등포구", "용산구", "은평구"],
        "경기": ["가평군", "고양시", "과천시", "광명시", "광주시", "구리시", "군포시", "김포시", "남양주시", "동두천시", "부천시", "성남시", "수원시", "시흥시", "안산시", "안양시", "양주시", "여주시", "연천군", "오산시", "용인시", "의왕시", "의정부시", "이천시", "파주시", "평택시", "포천시"],
        "인천": ["강화군", "계양구", "남동구", "남구", "동구", "부평구", "서구", "연수구"],
        "대전": ["대덕구", "동구", "서구", "중구"],
        "세종": ["세종특별자치시"],
        "충남": ["계룡시", "공주시", "금산군", "논산시", "당진시", "보령시", "부여군", "서산시", "서천군", "아산시", "예산군", "천안시", "청양군", "태안군"],
        "충북": ["괴산군", "단양군", "보은군", "영동군", "옥천군", "음성군", "제천시", "진천군", "청주시"],
        "부산": ["강서구", "금정구", "남구", "동구", "동래구", "북구", "사상구", "사하구", "서구", "수영구", "영도구", "중구"],
        "대구": ["남구", "달서구", "달성군", "동구", "북구", "서구", "수성구"],
        "경북": ["경산시", "경주시", "구미시", "김천시", "문경시", "상주시", "안동시", "영주시", "영천시", "포항시"],
        "경남": ["거제시", "김해시", "남해군", "밀양시", "사천시", "산청군", "양산시", "의령군", "진주시", "창원시", "창녕군", "통영시", "함안군", "함양군", "합천군"],
        "광주": ["광산구", "남구", "동구", "서구"],
        "전북": ["군산시", "김제시", "남원시", "익산시", "전주시", "장수군", "완주군", "임실군", "장성군", "진안군"],
        "전남": ["강진군", "고흥군", "곡성군", "광양시", "구례군", "나주시", "무안군", "목포시", "보성군", "순천시", "신안군", "여수시", "영광군", "영암군", "장흥군", "장성군", "진도군", "함평군"],
        "제주": ["제주시", "서귀포시"]
    ]
}

struct Category: Codable {
    var picked: String
    static let pickable: [String] = ["패스트푸드", "카페", "분식", "한식", "중식", "일식", "양식"]
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
    static let sampleData: SearchOption = .init(location: Location(province: .init(picked: Province.pickable[0]), city: .init(picked: City.pickable["서울"]![0]), category: .init(picked: Category.pickable[0])), sorting: .asc)
}
