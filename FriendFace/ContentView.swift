//
//  ContentView.swift
//  FriendFace
//
//  Created by Marcin Frydrych on 31/05/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
//    @State private var users = [User]()
    @Environment(\.modelContext) var modelContext
    @Query(sort: \User.name) private var users: [User]
    
    var body: some View {
        NavigationStack {
            List(users) { user in
                NavigationLink(value: user) {
                    HStack {
                        Circle()
                            .fill(user.isActive ? .green : .red)
                            .frame(width: 30)
                        
                        Text(user.name)
                    }
                }
            }
            .navigationTitle("FriendFace")
            .navigationDestination(for: User.self) { user in
                UserView(user: user)
            }
            .task {
                await fetchUsers()
            }
        }
    }
    
    func fetchUsers() async {
        // Don't re-fetch data if we already have it
        guard users.isEmpty else { return }
        
        do {
            let url = URL(string: "https://hws.dev/friendface.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            let downloadedUsers = try decoder.decode([User].self, from: data)
            
            // Creating new local modelContext wich has no auto save enabled
            let inserContext = ModelContext(modelContext.container)
            
            for user in downloadedUsers {
                inserContext.insert(user)
            }
            
            try inserContext.save()
            
        } catch {
            print("Download failed")
        }
        
    }
}

#Preview {
    ContentView()
}
