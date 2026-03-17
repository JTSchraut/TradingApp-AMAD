//
//  ItemView.swift
//  trade items
//
//  Created by SHANE COFFEY on 2/24/26.
//

import SwiftUI

struct ItemView: View {
    
    @State var item: Item
    var screenWidth: CGFloat = UIScreen.main.bounds.width
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(.ultraThickMaterial)
                .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 5)
                .overlay {
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                }
            
            VStack(alignment: .leading) {
                Spacer(minLength: 2)
                
                Text("\(item.name)")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.primary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
                
                Spacer()
                
                HStack(spacing: 5) {
                    Image(systemName: item.category.imageName)
                        .foregroundStyle(.secondary)
                    Text("\(item.category.rawValue)")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                        
                    Spacer()
                    
                    if item.estimatedValue != 0 {
                        Text("$\(item.estimatedValue, specifier: "%.0f")")
                            .font(.subheadline)
                            .foregroundStyle(.green)
                            .fontWeight(.bold)
                    }
                }
                
                Spacer(minLength: 2)
            }
            .padding(10)
        }
        .frame(width: screenWidth * 0.4, height: screenWidth * 0.4 / 1.618)
    }
}

#Preview {
    ItemView(item: Item(name: "Basketball", category: .sports, estimatedValue: 20, email: "test@gmail.com"))
}
