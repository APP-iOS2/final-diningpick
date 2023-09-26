//
//  Item.swift
//  DiningPick
//
//  Created by 한현민 on 2023/09/26.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
