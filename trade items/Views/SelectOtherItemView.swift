//
//  SelectOtherItemView.swift
//  trade items
//
//  Created by SHANE COFFEY on 3/13/26.
//

import SwiftUI
import FirebaseAuth
import FirebaseDatabase

struct SelectOtherItemView: View {
    
    @Environment(\.dismiss) private var dismiss
    let ref = Database.database().reference()
    
    @Binding var selectedItemId: String
    @State var items: [Item] = []
    
    var body: some View {
        
        NavigationStack{
            List(items, id:\.key){ item in
                
                ItemView(item: item)
                    .onTapGesture {
                        selectedItemId = item.key
                        dismiss()
                    }
            }
            .navigationTitle("Other's Items")
        }
        .onAppear{
            loadItems()
        }
    }
    
    func loadItems(){
        
        guard let myEmail = Auth.auth().currentUser?.email else { return }
        
        ref.child("items").observe(.childAdded){ snapshot in
            
            guard let dict = snapshot.value as? [String:Any] else { return }
            
            let item = Item(dict: dict)
            item.key = snapshot.key
            
            if item.email != myEmail {
                items.append(item)
            }
        }
    }
}
