//
//  UserView.swift
//  FriendFace
//
//  Created by Marcin Frydrych on 31/05/2024.
//

import SwiftUI

struct UserView: View {
    let user: User
    
    var body: some View {
        List {
            Section("About") {
                Text(user.about)
                    .padding(.vertical)
            }
            
            Section("Contact details") {
                Text("Address: \(user.address)")
                Text("Company: \(user.company)")
            }
            
            Section("Friends") {
                ForEach(user.friends) { friend in
                    Text(friend.name)
                }
            }
        }
        .listStyle(.grouped)
        .navigationTitle(user.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    UserView(user: .example)
}
