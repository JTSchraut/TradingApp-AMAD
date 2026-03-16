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
    
    @Environment(\.dismiss) private var dismiss
    
    @State var alertON = false
    @Binding var searchIN: String
    @Binding var estValIN: Double
    @Binding var categoryIN: ItemCategory?
    @Binding var useEstimatedValue: Bool
    @Binding var useCategory: Bool
    
    var body: some View {
        VStack(spacing: 24) {
            Text("Filter Items")
                .font(.largeTitle)
                .bold()
            
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Item Name")
                    .font(.headline)
                    .padding(.horizontal)
                TextField("Enter name", text: $searchIN)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
            }
            
            
            VStack(alignment: .leading, spacing: 8) {
                if useEstimatedValue {
                    Button("Disable Estimated Value Search") {
                        useEstimatedValue = false
                    }
                } else {
                    Button("Enable Estimated Value Search") {
                        useEstimatedValue = true
                    }
                }
                
                Text("Estimated value: $\(estValIN, specifier: "%.0f")")
                    .font(.headline)
                    .padding(.horizontal)
                
                HStack {
                    Button {
                        if estValIN > 1 {
                            estValIN -= 1
                        }
                    } label: {
                        Image(systemName: "minus.rectangle.fill")
                            .font(.largeTitle)
                            .foregroundStyle(.red.opacity(0.9))
                    }
                    
                    Slider(value: $estValIN, in: 1...100, step: 1)
                        .tint(.green)
                    
                    Button {
                        if estValIN < 100 {
                            estValIN += 1
                        }
                    } label: {
                        Image(systemName: "plus.rectangle.fill")
                            .font(.largeTitle)
                            .foregroundStyle(.green.opacity(0.9))
                    }
                }
                .disabled(!useEstimatedValue)
                .opacity(useEstimatedValue ? 1 : 0.4)
                .padding(.horizontal)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Category")
                    .font(.headline)
                    .padding(.horizontal)
                
                if useCategory {
                    Button("Disable Category Search") {
                        useCategory = false
                    }
                } else {
                    Button("Enable Category Search") {
                        useCategory = true
                    }
                }
                
                HStack(spacing: 20) {
                    ForEach(ItemCategory.allCases, id: \.self) { category in
                        Button {
                            categoryIN = category
                        } label: {
                            ZStack {
                                Circle()
                                    .fill(categoryIN == category ? .blue.opacity(0.9) : .gray.opacity(0.7))
                                    .frame(width: 100, height: 100)
                                
                                Text(category.rawValue)
                                    .foregroundStyle(.white)
                                    .font(.title3)
                                    .multilineTextAlignment(.center)
                                    .padding(5)
                            }
                        }
                    }
                }
                .disabled(!useCategory)
                .opacity(useCategory ? 1 : 0.4)
                .padding(.horizontal)
            }
            
            Button {
                dismiss()
            } label: {
                Text("Filter Items")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, minHeight: 60)
                    .background(.blue)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
        }
        .padding(.vertical)
    }
}
