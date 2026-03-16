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
    @State private var selection: Int = 0
    
    var body: some View {
        TabView(selection: $selection) {
            Tab("Your items", systemImage: "sharedwithyou", value: 0) {
                ListedItemsView()
            }
            
            Tab("Post", systemImage: "document.on.clipboard", value: 1) {
                ListItemView()
            }
            
            Tab("Send Offer", systemImage: "rectangle.portrait.and.arrow.right", value: 2) {
                OfferView()
            }
            
            Tab("Search", systemImage: "magnifyingglass", value: 3) {
                SearchView()
            }
            
            Tab("All items", systemImage: "list.clipboard", value: 4) {
                FindItemView()
            }
            
            Tab("Offers", systemImage: "square.and.arrow.down", value: 5) {
                OffersView()
            }
        }
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
