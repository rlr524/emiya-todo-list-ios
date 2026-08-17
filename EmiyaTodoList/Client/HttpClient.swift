//
//  HttpClient.swift
//  EmiyaTodoList
//
//  Created by Rob Ranf on 2026-08-17.
//
//  The HTTPClient file is a protocol that includes any code specific to creating the network
//  connectivity code.
//

import Foundation

protocol HttpClient {
    var session: URLSession { get }
    
    func load<T: Codable>(_ resource: Resource<T>) async throws -> T
}
