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
struct Location: Codable, Equatable {
    static func == (_ lhs: Location, _ rhs: Location) -> Bool {
        lhs.province == rhs.province &&
        lhs.city == rhs.city &&
        lhs.category == rhs.category
    }
    
    var province: Province
    var city: City
    var detail: String?     // 특별시/광역시/도, 시/군/구 그 다음에 오는 나머지 주소
    var category: Category
    
    var fullAddress: String {
        "\(province.picked) \(city.picked) \(detail ?? "")"
    }
}

struct Province: Codable, Equatable {
    static func == (_ lhs: Province, _ rhs: Province) -> Bool {
        // provider.location == option.location 이므로 option이 rhs에 해당
        if rhs.picked == "전체" {
            return true
        }
        return lhs.picked == rhs.picked
    }
    
    var picked: String
    static let pickable: [String] = ["전체", "서울", "경기", "인천", "대전", "세종", "충남", "충북", "부산", "대구", "경북", "경남", "광주", "전북", "전남", "제주"]
    
    static var locationPickable: [String] {
        Array(Province.pickable[1..<Province.pickable.count])
    }
}

struct City: Codable {
    static func == (_ lhs: City, _ rhs: City) -> Bool {
        if rhs.picked == "전체" {
            return true
        }
        return lhs.picked == rhs.picked
    }
    
    var picked: String
    static let pickable: [String: [String]] = [
        "전체": ["전체"],
        "서울": ["전체", "강남구", "강동구", "강북구", "강서구", "관악구", "광진구", "구로구", "금천구", "노원구", "도봉구", "동대문구", "동작구", "마포구", "서대문구", "서초구", "성동구", "성북구", "송파구", "양천구", "영등포구", "용산구", "은평구"],
        "경기": ["전체", "가평군", "고양시", "과천시", "광명시", "광주시", "구리시", "군포시", "김포시", "남양주시", "동두천시", "부천시", "성남시", "수원시", "시흥시", "안산시", "안양시", "양주시", "여주시", "연천군", "오산시", "용인시", "의왕시", "의정부시", "이천시", "파주시", "평택시", "포천시"],
        "인천": ["전체", "강화군", "계양구", "남동구", "남구", "동구", "부평구", "서구", "연수구"],
        "대전": ["전체", "대덕구", "동구", "서구", "중구"],
        "세종": ["전체"],
        "충남": ["전체", "계룡시", "공주시", "금산군", "논산시", "당진시", "보령시", "부여군", "서산시", "서천군", "아산시", "예산군", "천안시", "청양군", "태안군"],
        "충북": ["전체", "괴산군", "단양군", "보은군", "영동군", "옥천군", "음성군", "제천시", "진천군", "청주시"],
        "부산": ["전체", "강서구", "금정구", "남구", "동구", "동래구", "북구", "사상구", "사하구", "서구", "수영구", "영도구", "중구"],
        "대구": ["전체", "남구", "달서구", "달성군", "동구", "북구", "서구", "수성구"],
        "경북": ["전체", "경산시", "경주시", "구미시", "김천시", "문경시", "상주시", "안동시", "영주시", "영천시", "포항시"],
        "경남": ["전체", "거제시", "김해시", "남해군", "밀양시", "사천시", "산청군", "양산시", "의령군", "진주시", "창원시", "창녕군", "통영시", "함안군", "함양군", "합천군"],
        "광주": ["전체", "광산구", "남구", "동구", "서구", "북구"],
        "전북": ["전체", "군산시", "김제시", "남원시", "익산시", "전주시", "장수군", "완주군", "임실군", "장성군", "진안군"],
        "전남": ["전체", "강진군", "고흥군", "곡성군", "광양시", "구례군", "나주시", "무안군", "목포시", "보성군", "순천시", "신안군", "여수시", "영광군", "영암군", "장흥군", "장성군", "진도군", "함평군"],
        "제주": ["전체", "제주시", "서귀포시"]
    ]
    
    static var locationPickable: [String: [String]] {
        var ret: [String: [String]] = City.pickable
                
        for key in ret.keys {
            if ret[key]![0] == "전체" {
                return [key: [key]]
            } else {
                ret[key] = Array(ret[key]![1..<ret[key]!.count])
            }
        }
        
        debugPrint(ret)
        
        return ret
    }
}

struct Category: Codable {
    static func == (_ lhs: Category, _ rhs: Category) -> Bool {
        if rhs.picked == "전체" {
            return true
        }
        return lhs.picked == rhs.picked
    }
    
    var picked: String
    static let pickable: [String] = ["전체", "한식", "중식", "일식", "분식", "양식", "카페", "패스트푸드"]
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
    static let sampleData: SearchOption = .init(location: Location(province: .init(picked: Province.pickable[0]), city: .init(picked: City.pickable["전체"]![0]), category: .init(picked: Category.pickable[0])), sorting: .asc)
}
