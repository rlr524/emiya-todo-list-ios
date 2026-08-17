//
//  Item.swift
//  EmiyaTodoList
//
//  Created by Rob Ranf on 2026-08-17.
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
