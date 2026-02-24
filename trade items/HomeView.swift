//
//  HomeView.swift
//  trade items
//
//  Created by JAMES SCHRAUT on 2/23/26.
//

import SwiftUI

struct HomeView: View {
    @State var Username: String
    var body: some View {
        NavigationStack{
            VStack{
                Text("Welcome back \(Username)")
                    .font(.largeTitle)
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
}

#Preview {
    HomeView(Username: "blob")
}
