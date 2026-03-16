//
//  FindItemView.swift
//  trade items
//
//  Created by SHANE COFFEY on 3/2/26.
//

import SwiftUI
import FirebaseAuth
import FirebaseDatabase

struct FindItemView: View {
    
    let ref = Database.database().reference()
    @State var items: [Item] = []
    
    @State var selectedItem: Item? = nil
    
    var body: some View {
        VStack {
            Text("Other's Listed Items:")
                .font(.largeTitle)
            
            List(items, id: \.key) { item in
                ItemView(item: item)
                    .onTapGesture {
                        selectedItem = item
                    }
            }
        }
        .onAppear {
            items.removeAll()
            getItems()
        }
        .sheet(item: $selectedItem) { item in
            OfferView(selectedOtherItem: item)
        }
    }
    
    func getItems() {
        let itemsRef = ref.child("items")
        
        itemsRef.observe(.childAdded) { snapshot in
            guard let dict = snapshot.value as? [String: Any] else { return }
            if dict["email"] as? String == Auth.auth().currentUser?.email { return }
            
            let item = Item(dict: dict)
            item.key = snapshot.key
            items.append(item)
        }
        
        itemsRef.observe(.childRemoved) { snapshot in
            items.removeAll { $0.key == snapshot.key }
        }
        
        itemsRef.observe(.childChanged) { snapshot in
            guard let dict = snapshot.value as? [String: Any] else { return }
            guard let index = items.firstIndex(where: { $0.key == snapshot.key }) else { return }
            
            let updatedItem = Item(dict: dict)
            updatedItem.key = snapshot.key
            items[index] = updatedItem
        }
    }
}

#Preview {
    FindItemView()
}
