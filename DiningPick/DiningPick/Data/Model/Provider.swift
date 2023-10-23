//
//  Provider.swift
//  DiningPick
//
//  Created by 한현민 on 10/11/23.
//

import SwiftUI

struct Provider: Identifiable, Equatable, Codable {
    static func > (_ lhs: Provider, _ rhs: Provider) -> Bool {
        lhs.name > rhs.name
    }

    static func < (_ lhs: Provider, _ rhs: Provider) -> Bool {
        lhs.name < rhs.name
    }

    static func == (_ lhs: Provider, _ rhs: Provider) -> Bool {
        lhs.id == rhs.id && lhs.name == rhs.name
    }

    var id: String = UUID().uuidString
    var enrollNumber: String    // 사업자 등록번호
    var name: String            // 매장 이름
    var phoneNumber: String     // 매장 연락처 (지금은 String으로 했으나 3-3-4, 3-4-4자리 준수하는 별도의 인스턴스로 대체)
    var description: String     // 매장 설명
    var location: Location      // 매장 위치 (특별시/광역시/도, 시/군/구, 매장 카테고리)
    var time: Time              // 영업시간 등
    var articles: [Article]     // 작성한 게시글

    var noticeArticles: [Article] {
        articles.filter { article in
            article.type == .notice
        }
    }

    var menuArticles: [Article] {
        articles.filter { article in
            article.type == .menu
        }
    }
}

// TO DO: 시간의 경우 Date 타입인데, 시간 포맷은 24시간 포맷으로 쓴다. (ex) 19:00
// -> DateTimeHandler 싱글턴 객체에서 메서드 가져와서 변환
struct Time: Codable {
    var openTime: Date
    var closeTime: Date
    var lastOrderTime: Date
    var breakTimeStart: Date
    var breakTimeEnd: Date
    
    // 요일별로 영업시간 바뀔 수 있음에 유의!
    var operatingTimeString: String {
        let handler: DatetimeHandler = .getInstance(locale: .ko_KR, timezone: .Asia_Seoul)
        return "오늘 \(handler.getFormattedTimestamp(createdAt: openTime.timeIntervalSince1970, type: .Hm)) ~ \(handler.getFormattedTimestamp(createdAt: closeTime.timeIntervalSince1970, type: .Hm))"
    }

    var lastOrderTimeString: String {
        let handler: DatetimeHandler = .getInstance(locale: .ko_KR, timezone: .Asia_Seoul)
        return "주문마감 \(handler.getFormattedTimestamp(createdAt: lastOrderTime.timeIntervalSince1970, type: .Hm))"
    }

    var breakTimeString: String {
        let handler: DatetimeHandler = .getInstance(locale: .ko_KR, timezone: .Asia_Seoul)
        return "브레이크타임 \(handler.getFormattedTimestamp(createdAt: breakTimeStart.timeIntervalSince1970, type: .Hm)) ~ \(handler.getFormattedTimestamp(createdAt: breakTimeEnd.timeIntervalSince1970, type: .Hm))"
    }
}

struct Article: Identifiable, Equatable, Codable {
    static func < (_ lhs: Article, _ rhs: Article) -> Bool {
        lhs.date.timeIntervalSince1970 < rhs.date.timeIntervalSince1970
    }
    
    static func > (_ lhs: Article, _ rhs: Article) -> Bool {
        lhs.date.timeIntervalSince1970 > rhs.date.timeIntervalSince1970
    }
    
    static func == (_ lhs: Article, _ rhs: Article) -> Bool {
        lhs.date.timeIntervalSince1970.isEqual(to: rhs.date.timeIntervalSince1970) 
    }
    
    var id = UUID().uuidString
    var type: ArticleType
    var title: String
    var date: Date
    var likes: Int
    var image: ImageData
    var content: String?
    var menus: [String]?

    enum ArticleType: Codable {
        case notice
        case menu

        var description: String {
            switch self {
            case .notice:
                return "공지사항"
            case .menu:
                return "메뉴"
            }
        }
    }
}

struct ImageData: Codable {
    var image: Data?

    init(image: UIImage?) {
        if let image {
            self.image = image.pngData()
        }
    }
}

// TO DO: Provider 내용물을 Customer와 데이터 모델 통해 연결짓기
extension Provider {
    static let emptyData: Provider = .init(enrollNumber: "", name: "", phoneNumber: "", description: "", location: .init(province: .init(picked: ""), city: .init(picked: ""), category: .init(picked: "")), time: .init(openTime: .now, closeTime: .now, lastOrderTime: .now, breakTimeStart: .now, breakTimeEnd: .now), articles: [])
    
    static let sampleSimpleData: Provider = .init(id: "1A23D4F", enrollNumber: "1234-5678-9012", name: "구들장흑도야지", phoneNumber: "031-123-4567", description: "저희업소는 죽전 단국대학교앞 야외음악당 부근에 청정제주 흑돼지 및 오리구이 왕돌판구이 전문점으로 2007년 5월 오픈하여 고객여러분의 성원 덕분에 오늘에 이르렀습니다. 감사합니다!", location: .init(province: .init(picked: "경기도"), city: .init(picked: "용인시"), detail: "수지구 죽전로 176 죽전프라자2층", category: .init(picked: "한식")), time: .init(openTime: Date(timeIntervalSince1970: Date.now.timeIntervalSince1970 - 30000), closeTime: .now, lastOrderTime: .now, breakTimeStart: Date(timeIntervalSince1970: Date.now.timeIntervalSince1970 - 30000), breakTimeEnd: .now), articles: Article.sampleData)

    static let sampleData: [Provider] = [
        .init(id: "1A23D4F", enrollNumber: "1234-5678-9012", name: "구들장흑도야지", phoneNumber: "031-123-4567", description: "저희업소는 죽전 단국대학교앞 야외음악당 부근에 청정제주 흑돼지 및 오리구이 왕돌판구이 전문점으로 2007년 5월 오픈하여 고객여러분의 성원 덕분에 오늘에 이르렀습니다. 감사합니다!", location: .init(province: .init(picked: "경기도"), city: .init(picked: "용인시"), detail: "수지구 죽전로 176 죽전프라자2층", category: .init(picked: "한식")), time: .init(openTime: Date(timeIntervalSince1970: Date.now.timeIntervalSince1970 - 30000), closeTime: .now, lastOrderTime: .now, breakTimeStart: Date(timeIntervalSince1970: Date.now.timeIntervalSince1970 - 30000), breakTimeEnd: .now), articles: Article.sampleData),
        
        .init(enrollNumber: "1234-5678-9012", name: "구들장흑도야지", phoneNumber: "031-123-4567", description: "저희업소는 죽전 단국대학교앞 야외음악당 부근에 청정제주 흑돼지 및 오리구이 왕돌판구이 전문점으로 2007년 5월 오픈하여 고객여러분의 성원 덕분에 오늘에 이르렀습니다. 감사합니다!", location: .init(province: .init(picked: "경기"), city: .init(picked: "용인시"), category: .init(picked: "한식")), time: .init(openTime: Date(timeIntervalSince1970: Date.now.timeIntervalSince1970 - 30000), closeTime: .now, lastOrderTime: .now, breakTimeStart: Date(timeIntervalSince1970: Date.now.timeIntervalSince1970 - 30000), breakTimeEnd: .now), articles: Article.sampleData),

        .init(enrollNumber: "1234-5678-1232", name: "겐코", phoneNumber: "031-123-4567", description: "죽전 맛집", location: .init(province: .init(picked: "경기"), city: .init(picked: "용인시"), category: .init(picked: "한식")), time: .init(openTime: Date(timeIntervalSince1970: Date.now.timeIntervalSince1970 - 30000), closeTime: .now, lastOrderTime: .now, breakTimeStart: Date(timeIntervalSince1970: Date.now.timeIntervalSince1970 - 30000), breakTimeEnd: .now), articles: Article.sampleData),

        .init(enrollNumber: "1234-5678-9012", name: "해피덮", phoneNumber: "031-123-4567", description: "죽전 맛집", location: .init(province: .init(picked: "경기"), city: .init(picked: "용인시"), category: .init(picked: "한식")), time: .init(openTime: Date(timeIntervalSince1970: Date.now.timeIntervalSince1970 - 30000), closeTime: .now, lastOrderTime: .now, breakTimeStart: Date(timeIntervalSince1970: Date.now.timeIntervalSince1970 - 30000), breakTimeEnd: .now), articles: Article.sampleData),

        .init(enrollNumber: "1234-5678-1232", name: "역전우동", phoneNumber: "031-123-4567", description: "죽전 맛집", location: .init(province: .init(picked: "경기"), city: .init(picked: "용인시"), category: .init(picked: "한식")), time: .init(openTime: Date(timeIntervalSince1970: Date.now.timeIntervalSince1970 - 30000), closeTime: .now, lastOrderTime: .now, breakTimeStart: Date(timeIntervalSince1970: Date.now.timeIntervalSince1970 - 30000), breakTimeEnd: .now), articles: Article.sampleData),

        .init(enrollNumber: "1234-5678-1232", name: "팟퐁", phoneNumber: "031-123-4567", description: "죽전 맛집", location: .init(province: .init(picked: "경기"), city: .init(picked: "용인시"), category: .init(picked: "한식")), time: .init(openTime: Date(timeIntervalSince1970: Date.now.timeIntervalSince1970 - 30000), closeTime: .now, lastOrderTime: .now, breakTimeStart: Date(timeIntervalSince1970: Date.now.timeIntervalSince1970 - 30000), breakTimeEnd: .now), articles: Article.sampleData),

        .init(enrollNumber: "1234-5678-1232", name: "인도네팔레스토랑", phoneNumber: "031-123-4567", description: "죽전 맛집", location: .init(province: .init(picked: "경기"), city: .init(picked: "용인시"), category: .init(picked: "한식")), time: .init(openTime: Date(timeIntervalSince1970: Date.now.timeIntervalSince1970 - 30000), closeTime: .now, lastOrderTime: .now, breakTimeStart: Date(timeIntervalSince1970: Date.now.timeIntervalSince1970 - 30000), breakTimeEnd: .now), articles: Article.sampleData),

        .init(enrollNumber: "1234-5678-1232", name: "손가네칼국수", phoneNumber: "031-123-4567", description: "죽전 맛집", location: .init(province: .init(picked: "경기"), city: .init(picked: "용인시"), category: .init(picked: "한식")), time: .init(openTime: Date(timeIntervalSince1970: Date.now.timeIntervalSince1970 - 30000), closeTime: .now, lastOrderTime: .now, breakTimeStart: Date(timeIntervalSince1970: Date.now.timeIntervalSince1970 - 30000), breakTimeEnd: .now), articles: Article.sampleData),

        .init(enrollNumber: "1234-5678-1232", name: "홍춘", phoneNumber: "031-123-4567", description: "죽전 맛집", location: .init(province: .init(picked: "경기"), city: .init(picked: "용인시"), category: .init(picked: "한식")), time: .init(openTime: Date(timeIntervalSince1970: Date.now.timeIntervalSince1970 - 30000), closeTime: .now, lastOrderTime: .now, breakTimeStart: Date(timeIntervalSince1970: Date.now.timeIntervalSince1970 - 30000), breakTimeEnd: .now), articles: Article.sampleData),
    ]
}

extension Article {
    static let sampleData: [Article] = [
        .init(type: .notice, title: "휴점 안내", date: Date(timeIntervalSince1970: Date.now.timeIntervalSince1970 - 30000), likes: 202, image: .init(image: nil), content: "오늘 내부 공사로 인해 휴무합니다!"),
        .init(type: .notice, title: "휴점 안내", date: Date(timeIntervalSince1970: Date.now.timeIntervalSince1970 - 30000), likes: 202, image: .init(image: nil), content: "오늘 내부 공사로 인해 휴무합니다!"),
        .init(type: .notice, title: "휴점 안내", date: Date(timeIntervalSince1970: Date.now.timeIntervalSince1970 - 30000), likes: 202, image: .init(image: nil), content: "오늘 내부 공사로 인해 휴무합니다!"),
        .init(type: .notice, title: "휴점 안내", date: Date(timeIntervalSince1970: Date.now.timeIntervalSince1970 - 30000), likes: 202, image: .init(image: nil), content: "오늘 내부 공사로 인해 휴무합니다!"),
        .init(type: .menu, title: "오늘의 메뉴!", date: Date(timeIntervalSince1970: Date.now.timeIntervalSince1970 - 10000), likes: 46, image: .init(image: nil), menus: ["뚝배기불고기", "배추김치", "미니돈까스", "매실에이드", "미소장국"]),
        .init(type: .menu, title: "오늘의 메뉴!", date: Date(timeIntervalSince1970: Date.now.timeIntervalSince1970 - 10000), likes: 46, image: .init(image: nil), menus: ["뚝배기불고기", "배추김치", "미니돈까스", "매실에이드", "미소장국"]),
        .init(type: .menu, title: "오늘의 메뉴!", date: Date(timeIntervalSince1970: Date.now.timeIntervalSince1970 - 10000), likes: 46, image: .init(image: nil), menus: ["뚝배기불고기", "배추김치", "미니돈까스", "매실에이드", "미소장국"]),
        .init(type: .menu, title: "오늘의 메뉴!", date: Date(timeIntervalSince1970: Date.now.timeIntervalSince1970 - 10000), likes: 46, image: .init(image: nil), menus: ["뚝배기불고기", "배추김치", "미니돈까스", "매실에이드", "미소장국"]),
    ]
}
