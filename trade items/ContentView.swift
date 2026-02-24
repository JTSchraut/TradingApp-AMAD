//
//  ContentView.swift
//  trade items
//
//  Created by SHANE COFFEY on 2/20/26.
//

import SwiftUI

struct ContentView: View {
    @State var username = ""
    @State var password = ""
    var body: some View {
        NavigationStack{
            VStack {
                
                
                Text("Trading App")
                    .font(.largeTitle)
                Spacer()
                
                Text("Login")
                    .font(.title)
                HStack{
                    VStack{
                        TextField("Input username", text: $username)
                            .offset(x: 60)
                        TextField("Input password", text: $password)
                            .offset(x:60)
                        
                    }
                    Button {
                        
                    } label: {
                        ZStack{
                            Circle()
                                .frame(width: 100)
                            Text("Login")
                                .foregroundStyle(.red)
                        }
                        .offset(x: -50)
                    }
                }
                
                NavigationLink("Create new Account", destination: CreateAccountView())
                
                Spacer()
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
