//
//  HomeView.swift
//  trade items
//
//  Created by JAMES SCHRAUT on 2/23/26.
//

import SwiftUI
import FirebaseAuth

struct HomeView: View {
    
    @State var Username: String
    @Environment(\.dismiss) private var dismiss
    
    
    var body: some View {
        NavigationStack{
            VStack{
                Text("Welcome back \(Username)")
                    .font(.largeTitle)
                Button("sign out") {
                    signOut()
                }
                Spacer()
                HStack{
                    NavigationLink {
                        ListedItemsView()
                    } label: {
                        ZStack{
                            Circle()
                                .frame(width: 150)
                            Text("See Offers")
                                .foregroundStyle(.red)
                                .font(.title2)
                        }
                    }
                    
                    
                    NavigationLink {
                        ListedItemsView()
                    } label: {
                        ZStack{
                            Circle()
                                .frame(width: 150)
                            Text("See listed items")
                                .foregroundStyle(.red)
                                .font(.title2)
                        }
                    }
                }
                Spacer()
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
    HomeView(Username: "blob")
}
