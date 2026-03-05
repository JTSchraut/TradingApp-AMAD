//
//  SearchView.swift
//  trade items
//
//  Created by JAMES SCHRAUT on 3/2/26.
//

import SwiftUI
import FirebaseAuth
import FirebaseDatabase

struct SearchView: View {
    @State var alertON = false
    @State var searchIN = ""
    @State var estValIN = 1.0
    @State var categoryIN = "sports"
    var body: some View {
        NavigationStack{
            
            Text("Search For Items")
                .font(.largeTitle)
            TextField("Search", text: $searchIN)
                .background {
                    RoundedRectangle(cornerSize: .zero)
                        .foregroundStyle(.teal)
                }
            Text("Filter by:")
            HStack{
                Text("Estimated Value: $\(estValIN, specifier: "%.0f")")
                Stepper("", value: $estValIN)
            }
            Slider(value: $estValIN, in: 1...100, step: 1.0 ) {_ in
                
            }
                

            Text("Select category:")
                .font(.title2)
            Text("Current: \(categoryIN)")
            ScrollView {
                Button {
                    categoryIN = "sports"
                } label: {
                    ZStack{
                        RoundedRectangle(cornerSize: CGSize(width: 10.0, height: 15.0))
                            .frame(width: 250,height: 35)
                            .foregroundStyle(.blue)
                        Text("Sports")
                            .foregroundStyle(.red)
                            .font(.title)
                    }
                }
                
                Button {
                    categoryIN = "technology"
                } label: {
                    ZStack{
                        RoundedRectangle(cornerSize: CGSize(width: 10.0, height: 15.0))
                            .frame(width: 250,height: 35)
                            .foregroundStyle(.blue)
                        Text("Technology")
                            .foregroundStyle(.red)
                            .font(.title)
                    }
                }
                
                Button {
                    categoryIN = "clothing"
                } label: {
                    ZStack{
                        RoundedRectangle(cornerSize: CGSize(width: 10.0, height: 15.0))
                            .frame(width: 250,height: 35)
                            .foregroundStyle(.blue)
                        Text("Clothing")
                            .foregroundStyle(.red)
                            .font(.title)
                    }
                }
            }
                
            Spacer()
            Spacer()
            Spacer()
            Button {
                filter(name: searchIN, category: categoryIN, estVal: estValIN)
            } label: {
                ZStack{
                    Circle()
                        .frame(width: 150)
                    Text("Find Items")
                        .foregroundStyle(.red)
                        .font(.title2)
                }
            }
            
            Spacer()
        }
        .alert("Invalid search parameters", isPresented: $alertON) {
            
        }
    }
    
    func filter(name: String, category: String, estVal: Double){
        
        var itemArray: [Item] = []
        let ref = Database.database().reference().child("items")
        ref.observeSingleEvent(of: .value, with: { snapshot in
           for snap in snapshot.children.allObjects as! [DataSnapshot] {
               let key = snap.key
               if let dict = snap.value as? [String: Any] {
                   itemArray.append(Item(dict: dict))
               }
           }
        })
        
        var arrayOUT: [Item] = []
        for i in 0..<itemArray.count {
            if itemArray[i].name.contains(name) && category == itemArray[i].category.rawValue && abs(itemArray[i].estimatedValue - estVal) < 10.0 {
                arrayOUT.append(itemArray[i])
                print(itemArray[i].name)
            }
        }
    }
}

#Preview {
    SearchView()
}
