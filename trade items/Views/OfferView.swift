//
//  OfferView.swift
//  trade items
//
//  Created by JAMES SCHRAUT on 2/25/26.
//
import SwiftUI

struct OfferView: View {
    @State var offerIN : Offer
    var body: some View {
        NavigationStack{
            VStack{
                Text("Offer details")
                    .font(.largeTitle)
                Spacer()
                
                
                HStack{
                    Text("You recieve:")
                        .font(.title2)
                    ItemView(item: offerIN.itemIN)
                }
                
                Spacer()
                HStack{
                    
                    Text("You lose:")
                        .font(.title2)
                    ItemView(item: offerIN.itemOUT)
                    }
                Spacer()
                
                Spacer()
                }
                
            
        }
        
    }
}

#Preview {
    OfferView(offerIN: Offer(itemIN: Item(name: "slop", category: ItemCategory(rawValue: "Sports")!, estimatedValue: 1.0, email: "oogabooga"), itemOUT: Item(name: "Gloop", category: ItemCategory(rawValue: "Technology")!, estimatedValue: 10.0, email: "blipblop")))
}
