//
//  ProductDetailView.swift
//  FakeStore
//
//  Created by Martin Bucko on 18/11/2024.
//

import SwiftUI

struct ProductDetailView: View {
    @StateObject private var viewModel: ProductDetailViewModel
    
    init(productId: Int) {
        self._viewModel = StateObject(wrappedValue: ProductDetailViewModel(productId: productId))
    }
    
    var body: some View {
        ZStack {
            if let product = viewModel.product {
                ScrollView {
                    ProductImageView(url: URL(string: product.image))
                        .frame(width: 200, height: 200)
                    
                    VStack(alignment: .leading, spacing: 32) {
                        Text(product.title)
                            .font(.headline)
                            .foregroundStyle(.blue)
                        
                        Text(product.description)
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                        
                        HStack {
                            VStack(alignment: .leading) {
                                Text("product.detail.id".localize())
                                    .font(.footnote)
                                
                                Text("\(product.id)")
                                    .font(.headline)
                            }
                            
                            Spacer()
                            
                            VStack(alignment: .trailing) {
                                Text("product.detail.price".localize())
                                    .font(.footnote)
                                
                                Text(product.price, format: .currency(code: "EUR"))
                                    .font(.headline)
                            }
                        }
                    }
                    .padding(32)
                }
            } else {
                ProgressView()
                    .controlSize(.large)
            }
        }
        .navigationTitle(viewModel.product?.category ?? "")
        .navigationBarTitleDisplayMode(.inline)
        .task { await viewModel.fetchProduct() }
    }
}

#Preview {
    NavigationView {
        ProductDetailView(productId: 1)
    }
    .preferredColorScheme(.light)
}

#Preview {
    NavigationView {
        ProductDetailView(productId: 1)
    }
    .preferredColorScheme(.dark)
}
