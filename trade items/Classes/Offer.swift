//
//  Offer.swift
//  trade items
//
//  Created by JAMES SCHRAUT on 3/11/26.
//

import Foundation
class Offer {
    
    var id: String = ""
    var offerIN: Item
    var offerOUT: Item
    
    init(offerIN: Item, offerOUT: Item) {
        self.offerIN = offerIN
        self.offerOUT = offerOUT
    }
}
