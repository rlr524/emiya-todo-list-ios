//
//  EmiyaTodoListApp.swift
//  EmiyaTodoList
//
//  Created by Rob Ranf on 2026-08-17.
//

import SwiftUI
import SwiftData

@main
struct EmiyaTodoListApp: App {
    @State private var store = Store(webService: WebService())
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.environment(store)
    }
}
