//
//  Models.swift
//  EmiyaTodoList
//
//  Created by Rob Ranf on 2026-08-17.
//

import Foundation
import SwiftData

enum ItemImportance: String, Codable, CaseIterable, Identifiable {
    case low = "Low"
    case medium = "Medium"
    case high = "High"
    
    var id: Self { return self }
}

@Model public class Item: Codable, Identifiable, Hashable {
    enum CodingKeys: CodingKey {
        case id, title, itemDescription, due, importance, complete, owner, deleted
    }
    
    // ISO 8601 date formatter for Java LocalDate compatibility (yyyy-MM-dd)
    private static let localDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(identifier: "UTC")
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
    
    @Attribute(.unique) public var id: String
    var title: String
    var itemDescription: String
    var due: Date
    var importance: ItemImportance
    var complete: Bool
    var owner: String
    var deleted: Bool
    
    init(
        id: String,
        title: String,
        itemDescription: String,
        due: Date,
        importance: ItemImportance,
        complete: Bool,
        owner: String,
        deleted: Bool
    ) {
        self.id = id
        self.title = title
        self.itemDescription = itemDescription
        self.due = due
        self.importance = importance
        self.complete = complete
        self.owner = owner
        self.deleted = deleted
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        itemDescription = try container.decode(String.self, forKey: .itemDescription)
        
        // Decode the date string from JSON(Java LocalDate format: yyyy-MM-dd)
        let dueString = try container.decode(String.self, forKey: .due)
        if let date = Item.localDateFormatter.date(from: dueString) {
            due = date
        } else {
            // Fallback if date parsing fails
            throw DecodingError.dataCorruptedError(
                forKey: .due,
                in: container,
                debugDescription: "Date string does not match expected format: yyyy-MM-dd"
            )
        }
        
        importance = try container.decode(ItemImportance.self, forKey: .importance)
        complete = try container.decode(Bool.self, forKey: .complete)
        owner = try container.decode(String.self, forKey: .owner)
        deleted = try container.decode(Bool.self, forKey: .deleted)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(itemDescription, forKey: .itemDescription)
        
        // Encode the date as a string in Java LocalDate format (yyyy-MM-dd)
        let dateString = Item.localDateFormatter.string(from: due)
        try container.encode(dateString, forKey: .due)
        
        try container.encode(importance, forKey: .importance)
        try container.encode(complete, forKey: .complete)
        try container.encode(owner, forKey: .owner)
        try container.encode(deleted, forKey: .deleted)
    }
}
