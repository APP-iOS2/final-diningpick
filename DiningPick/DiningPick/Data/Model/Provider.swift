//
//  Provider.swift
//  DiningPick
//
//  Created by 한현민 on 10/11/23.
//

import Foundation

struct Provider: Identifiable, Codable {
    var id = UUID().uuidString
    var name: String
    var province: String
    var city: String
    var addressDetail: String
    var time: Time
    var mealType: String
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

extension Provider {
    static let sampleData: Provider = .init(name: "구들장흑도야지", province: "경기도", city: "용인시", addressDetail: "수지구 용인시 죽전로 140 103", time: .init(openTime: .now, closeTime: .now, lastOrderTime: .now, breakTimeStart: .now, breakTimeEnd: .now), mealType: "한식")
}
