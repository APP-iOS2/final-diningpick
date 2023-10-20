//
//  DateTimeHandler.swift
//  DiningPick
//
//  Created by 한현민 on 10/11/23.
//

// Locale, Timezone, TimeInterval, TimestampType 4개를 받아
// 원하는 형태의 Timestamp를 받을 수 있다.

// 사용 예시
// DatetimeHandler.getInstance(locale: .ko_KR, timezone: .Asia_Seoul).getFormattedTimestamp(createdAt: Date.now.timeIntervalSince1970, type: .Hm)

import Foundation

enum AvailableLocale {
    case ko_KR, en_US
    
    var locale: String {
        switch self {
        case .ko_KR:
            return Locale(identifier: "ko_KR").identifier
        case .en_US:
            return Locale(identifier: "en_US").identifier
        }
    }
}

enum AvailableTimeZone {
    case Asia_Seoul, America_New_York
    
    // handler 내부에서 timezone 받을 때 강제 언래핑이 실행된다.
    // 따라서, 옵셔널로 넘겨도 된다.
    var timezone: String {
        switch self {
        case .Asia_Seoul:
            return TimeZone(abbreviation: "Asia_Seoul")?.identifier ?? ""
        case .America_New_York:
            return TimeZone(abbreviation: "America_New_York")?.identifier ?? ""
        }
    }
}

enum TimestampType {
    case Hm         // HH시 mm분
    case yMd        // yyyy-MM-dd
    case yMdHm      // yyyy.MM.dd.HH.mm
    case MdHm       // MM/dd HH시 mm분
    
    var format: String {
        switch self {
        case .Hm:
            return "HH:mm"
        case .yMd:
            return "yyyy-MM-dd"
        case .yMdHm:
            return "yyyy년 MM월 dd일 HH:mm"
        case .MdHm:
            return "MM/dd HH시 mm분"
        }
    }
}

class DatetimeHandler {
//    usage:
//    DatetimeHandler.getInstance().getFormattedTimestamp(createdAt: TimeInterval, type: TimestampType)
    private static var handler: DatetimeHandler? = nil
    
    // DateFormatter 객체가 Singleton 객체인 handler에 묶여 있어서,
    // DateFormatter 객체는 프로그램 전체에 걸쳐 한 번만 생성되므로
    // 성능을 아낄 수 있다. (핵심)
    private var formatter: DateFormatter = .init()
    private var locale: String
    private var timezone: String
    
    private init(_ locale: String, _ timezone: String) {
        self.locale = locale
        self.timezone = timezone
    }
    
    static func getInstance(locale: AvailableLocale, timezone: AvailableTimeZone) -> DatetimeHandler {
        // 인스턴스가 할당되어 있지 않으면 초기값 지정하며 인스턴스 생성하고,
        // 인스턴스가 할당되어 있다면 인스턴스에 새로운 값을 할당한 후
        // 인스턴스를 반환한다.
        if self.handler == nil {
            self.handler = .init(locale.locale, timezone.timezone)
        } else {
            self.handler?.locale = locale.locale
            self.handler?.timezone = timezone.timezone
        }
        return self.handler!
    }
    
    // 실제 값 반환
    func getFormattedTimestamp(createdAt: TimeInterval, type: TimestampType) -> String {
        let dateCreatedAt: Date = Date(timeIntervalSince1970: createdAt)
        
        self.formatter.locale = Locale(identifier: self.locale)
        self.formatter.timeZone = TimeZone(abbreviation: self.timezone)
        self.formatter.dateFormat = type.format
        
        return self.formatter.string(from: dateCreatedAt)
    }
}
