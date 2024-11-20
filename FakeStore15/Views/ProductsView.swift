//
//  ProductsView.swift
//  FakeStore
//
//  Created by Martin Bucko on 18/11/2024.
//

import SwiftUI

struct ProductsView: View {
    @State private var products: [Product] = []
    @State private var categories: [String] = []
    @State private var selectedCategory: String? = nil
    @State private var showFilter: Bool = false
    
    var body: some View {
        List(products) { product in
            NavigationLink {
                ProductDetailView(productId: product.id)
            } label: {
                ProductRow(product: product)
            }
        }
        .listStyle(.inset)
        .navigationTitle(selectedCategory ?? "Produkty")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Filter") {
                    showFilter.toggle()
                }
            }
        }
        .confirmationDialog("Filter", isPresented: $showFilter) {
            if let selectedCategory {
                Button("Zrusit filter \(selectedCategory)", role: .destructive) {
                    self.selectedCategory = nil
                }
            }
            
            ForEach(categories, id: \.self) { category in
                if category != selectedCategory {
                    Button(category) {
                        selectedCategory = category
                    }
                }
            }
        }
        .task(id: selectedCategory) { await fetchData() }
    }
    
    private func fetchData() async {
        products = (try? await NetworkService.shared.fetchProducts(category: selectedCategory)) ?? []
        categories = (try? await NetworkService.shared.fetchCategories()) ?? []
    }
}

struct ProductRow: View {
    let product: Product
    
    var body: some View {
        HStack {
            ProductImageView(url: URL(string: product.image))
                .frame(width: 50, height: 50)
            
            VStack(alignment: .leading) {
                Text(product.title)
                    .font(.subheadline)
                    .lineLimit(2)
                
                Text(product.category)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

struct ProductImageView: View {
    let url: URL?
    
    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
            case .failure:
                Image(systemName: "photo")
                    .font(.title)
                    .foregroundStyle(.secondary)
            default:
                ProgressView()
            }
        }
    }
}

#Preview {
    NavigationView {
        ProductsView()
    }
    .preferredColorScheme(.light)
}

#Preview {
    NavigationView {
        ProductsView()
    }
    .preferredColorScheme(.dark)
}
