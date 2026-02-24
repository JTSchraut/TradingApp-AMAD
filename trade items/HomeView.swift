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
        Text("Welcome back \(Username)")
            .font(.largeTitle)
        
        
        
        
        
        Spacer()
    }
}

#Preview {
    HomeView(Username: "blob")
}
