//
//  Provider.swift
//  DiningPick
//
//  Created by 한현민 on 10/11/23.
//

import Foundation

struct Provider: Identifiable, Codable {
    var id: String
    var enrollNumber: String // 사업자 등록번호
    var name: String
    var province: String
    var city: String
    var addressDetail: String
    var time: Time
    var mealType: String

    var fullAddress: String {
        "\(province) \(city) \(addressDetail)"
    }

    // 요일별로 영업시간 바뀔 수 있음에 유의!
    var operatingTime: String {
        let handler: DatetimeHandler = .getInstance(locale: .ko_KR, timezone: .Asia_Seoul)
        return "오늘 \(handler.getFormattedTimestamp(createdAt: time.openTime.timeIntervalSince1970, type: .Hm)) ~ \(handler.getFormattedTimestamp(createdAt: time.closeTime.timeIntervalSince1970, type: .Hm))"
    }

    var lastOrderTime: String {
        let handler: DatetimeHandler = .getInstance(locale: .ko_KR, timezone: .Asia_Seoul)
        return "주문마감 \(handler.getFormattedTimestamp(createdAt: time.lastOrderTime.timeIntervalSince1970, type: .Hm))"
    }

    var breakTime: String {
        let handler: DatetimeHandler = .getInstance(locale: .ko_KR, timezone: .Asia_Seoul)
        return "브레이크타임 \(handler.getFormattedTimestamp(createdAt: time.breakTimeStart.timeIntervalSince1970, type: .Hm)) ~ \(handler.getFormattedTimestamp(createdAt: time.breakTimeEnd.timeIntervalSince1970, type: .Hm))"
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
}

// TO DO: Provider 내용물을 Customer와 데이터 모델 통해 연결짓기
extension Provider {
    static let sampleSimpleData: Provider = .init(id: "1A23D4F", enrollNumber: "1234-5678-9012", name: "구들장흑도야지", province: "경기도", city: "용인시", addressDetail: "수지구 용인시 죽전로 140 103", time: .init(openTime: Date(timeIntervalSince1970: Date.now.timeIntervalSince1970 - 30000), closeTime: .now, lastOrderTime: .now, breakTimeStart: Date(timeIntervalSince1970: Date.now.timeIntervalSince1970 - 30000), breakTimeEnd: .now), mealType: "한식")

    static let sampleData: [Provider] = [
        .init(id: "1A23D4F", enrollNumber: "1234-5678-9012", name: "구들장흑도야지", province: "경기도", city: "용인시", addressDetail: "수지구 용인시 죽전로 140 103", time: .init(openTime: Date(timeIntervalSince1970: Date.now.timeIntervalSince1970 - 30000), closeTime: .now, lastOrderTime: .now, breakTimeStart: Date(timeIntervalSince1970: Date.now.timeIntervalSince1970 - 30000), breakTimeEnd: .now), mealType: "한식"),

        .init(id: "3BA3D4F", enrollNumber: "1234-5678-1232", name: "한솥도시락 죽전단국대점", province: "경기도", city: "용인시", addressDetail: "수지구 용인시 죽전로 140 103", time: .init(openTime: Date(timeIntervalSince1970: Date.now.timeIntervalSince1970 - 30000), closeTime: .now, lastOrderTime: .now, breakTimeStart: Date(timeIntervalSince1970: Date.now.timeIntervalSince1970 - 30000), breakTimeEnd: .now), mealType: "한식"),
    ]
}
