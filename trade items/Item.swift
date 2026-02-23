//
//  Item.swift
//  trade items
//
//  Created by SHANE COFFEY on 2/23/26.
//

import Foundation

enum ItemCategory: String {
    case clothing = "Clothing"
    case technology = "Technology"
    case sports = "Sports"
}

class Item {
    var name: String
    var category: ItemCategory
    var estimatedValue: Double
    
    init(name: String, category: ItemCategory, estimatedValue: Double) {
        self.name = name
        self.category = category
        self.estimatedValue = estimatedValue
    }
}
