//
//  OffersView.swift
//  trade items
//
//  Created by SHANE COFFEY on 3/13/26.
//

import SwiftUI
import FirebaseDatabase
import FirebaseAuth

struct OffersView: View {
    
    let ref = Database.database().reference()
    
    @State var loaded = false
    @State var offers: [Offer] = []
    
    var body: some View {
        NavigationStack {
            Text("Incoming offers")
                .font(.title)
            
            List(offers, id: \.offerIN.key) { offer in
                VStack {
                    Text("Offer:")
                        .font(.headline)
                    
                    HStack {
                        VStack {
                            Text("You recieve:")
                            ItemView(item: offer.offerOUT)
                        }
                        
                        Spacer()
                        
                        VStack {
                            Text("You give:")
                            ItemView(item: offer.offerIN)
                        }
                    }
                    
                    HStack {
                        Button("Accept") {
                            
                        }
                        
                        Spacer()
                        
                        Button("Decline") {
                            
                        }
                    }
                }
            }
            .onAppear() {
                if !loaded {
                    loadOffers()
                }
            }
        }
    }
    
    func loadOffers() {
        
        print("loading")
        
        loaded = true
        
        guard let myEmail = Auth.auth().currentUser?.email else {
            print("couldnt get email")
            return
        }
        
        ref.child("offers").observe(.childAdded) { snapshot in
            guard let dict = snapshot.value as? [String:Any],
                  let offerIN = dict["offerIN"] as? String,
                  let offerOUT = dict["offerOut"] as? String else {
                print("couldnt make starter dict")
                return
            }

            ref.child("items").child(offerIN).observeSingleEvent(of: .value) { snapIN in
                guard let dictIN = snapIN.value as? [String:Any] else {
                    print("couldnt make dictIN")
                    return
                }

                let itemIN = Item(dict: dictIN)
                itemIN.key = offerIN

                if itemIN.email != myEmail {
                    print("Did not use email: \(itemIN.email) for \(itemIN.name)")
                    return
                }

                ref.child("items").child(offerOUT).observeSingleEvent(of: .value) { snapOUT in
                    guard let dictOUT = snapOUT.value as? [String:Any] else { return }

                    let itemOUT = Item(dict: dictOUT)
                    itemOUT.key = offerOUT

                    let offer = Offer(offerIN: itemIN, offerOUT: itemOUT)

                    DispatchQueue.main.async {
                        offers.append(offer)
                    }
                }
            }
        }
        
        print("done loading")
    }
}

#Preview {
    OffersView()
}
