//
//  Item.swift
//  trade items
//
//  Created by SHANE COFFEY on 2/23/26.
//

import Foundation
import Firebase
import FirebaseCore
import FirebaseAuth
import FirebaseDatabase




enum ItemCategory: String {
    case clothing = "Clothing"
    case technology = "Technology"
    case sports = "Sports"
    
}

class Item: ObservableObject {
    var ref = Database.database().reference()
    var name: String
    var category: ItemCategory
    var estimatedValue: Double
    var key = ""
    
    init(name: String, category: ItemCategory, estimatedValue: Double) {
        self.name = name
        self.category = category
        self.estimatedValue = estimatedValue
    }
    //pull from FBase
    init(dict:[String : Any]){
        name = dict["name"] as! String
        let categoryString = dict["category"] as? String ?? ""
        category = ItemCategory(rawValue: categoryString) ?? .sports
        estimatedValue = dict["estimatedValue"] as! Double
    }
    
    func toDict() -> [String: Any] {
        return [
            "name": name,
            "category": category.rawValue,
            "estimatedValue": estimatedValue
        ]
    }
    
    func save(){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        // this is so ugly but we need the layers
        let newRef = ref.child("users").child(uid).child("items").childByAutoId()
        key = newRef.key ?? ""
        newRef.setValue(toDict())
    }
    
    func delete() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        ref.child("users").child(uid).child("items").child(key).removeValue()
    }
    
    func update() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        ref.child("users").child(uid).child("items").child(key).updateChildValues(toDict())
    }
}
