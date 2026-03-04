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
    @State var testText = "hi"
    
    @State var items: [Item] = []
    
    var body: some View {
        VStack {
            Text("Other's Listed Items:")
                .font(.largeTitle)
            
            Text(testText)
            
            List(items, id: \.key) { item in
                ItemView(item: item)
                    .swipeActions {
                        Button("Delete") {
                            item.delete()
                        }
                        .tint(.red)
                    }
            }
        }
        .onAppear {
            getItems()
        }
    }
    
    
    /*
     items
     --item ids
     users
     --userid
     ----items
     ------itemIds
     --------category
     --------name
     */
    func getItems() {
        ref.child("items").observe(.childAdded) { snapshot,arg   in
            guard let id = snapshot.value as? [String: Any] else { return } // id of the item
            
            // let item = Item()
            // item.key = snapshot.key
            
            // items.append(item)
        }
        
        ref.child("items").observe(.childRemoved) { snapshot in
            // remove all items where the key == snapshot key
            items.removeAll { $0.key == snapshot.key }
        }
        
        ref.child("items").observe(.childChanged) { snapshot in
            guard let dict = snapshot.value as? [String: Any] else { return }
            
            let key = snapshot.key
            
            if let index = items.firstIndex(where: {$0.key == key}) {
                let updatedItem = Item(dict: dict)
                updatedItem.key = key
                items[index] = updatedItem
            }
        }
    }
}

#Preview {
    FindItemView()
}
