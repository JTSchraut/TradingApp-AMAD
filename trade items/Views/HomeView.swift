//
//  HomeView.swift
//  trade items
//
//  Created by JAMES SCHRAUT on 2/23/26.
//

import SwiftUI
import FirebaseAuth

struct HomeView: View {
    
    var user: User? {
        Auth.auth().currentUser
    }
    @Environment(\.dismiss) private var dismiss
    @State private var selection: Int = 2
    @State var incomingOffers = 0
    
    var body: some View {
        TabView(selection: $selection) {
            Tab("Outgoing", systemImage: "arrow.up.square.fill", value: 0) {
                OutgoingOffersView()
            }
            
            Tab("My Items", systemImage: "archivebox", value: 1) {
                ListedItemsView()
            }
            
            Tab("Home", systemImage: "house", value: 2) {
                WelcomeView()
            }
            
            Tab("Browse", systemImage: "list.bullet.rectangle", value: 3) {
                FindItemView()
            }
            
            Tab("Incoming", systemImage: "arrow.down.square.fill", value: 4) {
                OffersView()
            }
            .badge(incomingOffers)
        }
        .toolbarBackground(.ultraThinMaterial, for: .tabBar)
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            dismiss()
        } catch {
            print("Sign out error: \(error.localizedDescription)")
        }
    }
}

#Preview {
    HomeView()
}
