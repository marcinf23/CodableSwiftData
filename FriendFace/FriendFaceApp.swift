//
//  FriendFaceApp.swift
//  FriendFace
//
//  Created by Marcin Frydrych on 31/05/2024.
//

import SwiftUI
import SwiftData

@main
struct FriendFaceApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
