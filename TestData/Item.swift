//
//  Item.swift
//  TestData
//
//  Created by Serhii on 26.11.2024.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date = Date()
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
