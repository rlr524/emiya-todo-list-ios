//
//  Constants.swift
//  EmiyaTodoList
//
//  Created by Rob Ranf on 2026-08-17.
//

import Foundation
import SwiftUI

struct K {
    static let environment: String = "prod"
    static let version: String = "v1"
    static let devBaseURL: String = "http://localhost:8080/api/"
    static let prodBaseURL: String = "https://api.emiyanet.com/api/"
    static let baseUrl: String = environment == "dev"
    ? (devBaseURL + version)
    : (prodBaseURL + version)
    
    struct URLs {
        static func getItems() -> URL {
            return URL(string: "\(baseUrl)/items")!
        }
        
        static func getItemById(id: String) -> URL {
            return URL(string: "\(baseUrl)/item/\(id)")!
        }
        
        static func createItem() -> URL {
            return URL(string: "\(baseUrl)/item")!
        }
        
        static func updateItem() -> URL {
            return URL(string: "\(baseUrl)/item")!
        }
        
        static func deleteItem(id: String) -> URL {
            return URL(string: "\(baseUrl)/item/\(id)")!
        }
    }
}
