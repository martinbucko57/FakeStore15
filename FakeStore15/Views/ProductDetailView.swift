//
//  ProductDetailView.swift
//  FakeStore
//
//  Created by Martin Bucko on 18/11/2024.
//

import SwiftUI

struct ProductDetailView: View {
    @State private var product: Product?
    let productId: Int
    
    var body: some View {
        ZStack {
            if let product {
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
                                Text("ID produktu:")
                                    .font(.footnote)
                                
                                Text("\(product.id)")
                                    .font(.headline)
                            }
                            
                            Spacer()
                            
                            VStack(alignment: .trailing) {
                                Text("Cena:")
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
        .navigationTitle(product?.category ?? "")
        .navigationBarTitleDisplayMode(.inline)
        .task { await fetchProduct() }
    }
    
    private func fetchProduct() async {
        product = try? await NetworkService.shared.fetchProductDetail(productId: productId)
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
