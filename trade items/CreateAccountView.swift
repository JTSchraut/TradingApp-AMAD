//
//  CreateAccountView.swift
//  trade items
//
//  Created by JAMES SCHRAUT on 2/23/26.
//

import SwiftUI

struct CreateAccountView: View {
    @State var username = ""
    @State var password = ""
    @State var alertON = false
    var body: some View {
        NavigationStack{
            VStack {
                
                
                Text("Trading App")
                    .font(.largeTitle)
                Spacer()
                
                Text("Create Account")
                    .font(.title)
                HStack{
                    VStack{
                        TextField("Input new username", text: $username)
                            .offset(x: 60)
                        TextField("Input new password", text: $password)
                            .offset(x:60)
                        
                    }
                    Button {
                        if password.count < 6 {
                            alertON = true
                        }else{
                            //new acc code here
                            
                            
                            
                        }
                    } label: {
                        ZStack{
                            Circle()
                                .frame(width: 100)
                            Text("Create")
                                .foregroundStyle(.red)
                        }
                        .offset(x: -50)
                    }
                }
                
                
                
                Spacer()
                Spacer()
            }
            .padding()
        }
        .alert("Password must be at least 6 characters", isPresented: $alertON) {
            
        }
    }
}

#Preview {
    CreateAccountView()
}
