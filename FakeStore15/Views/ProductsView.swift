//
//  ProductsView.swift
//  FakeStore
//
//  Created by Martin Bucko on 18/11/2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProductsView: View {
    @StateObject private var viewModel: ProductsViewModel = ProductsViewModel()
    
    var body: some View {
        content
            .navigationTitle(viewModel.selectedCategory ?? "product.list.title".localize())
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Filter", systemImage: "line.3.horizontal.decrease") {
                        viewModel.filterTapped()
                    }
                }
            }
            .confirmationDialog("Filter", isPresented: $viewModel.showFilter) {
                if let selectedCategory = viewModel.selectedCategory {
                    Button("\("product.list.filter.remove".localize()) \(selectedCategory)", role: .destructive) {
                        viewModel.resetCategory()
                    }
                }
                
                ForEach(viewModel.categories, id: \.self) { category in
                    if category != viewModel.selectedCategory {
                        Button(category) {
                            viewModel.selectCategory(category)
                        }
                    }
                }
            }
            .task(id: viewModel.selectedCategory) { await viewModel.fetchData() }
            .refreshable { await viewModel.fetchData() }
    }
    
    @ViewBuilder
    private var content: some View {
        if viewModel.isLoading {
            ProgressView()
                .controlSize(.large)
        } else {
            List(viewModel.products) { product in
                NavigationLink {
                    ProductDetailView(productId: product.id)
                } label: {
                    ProductRow(product: product)
                }
            }
            .emptyState(viewModel.products.isEmpty) {
                Text("product.list.empty.message".localize())
            }
        }
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
        WebImage(url: url) { image in
            image
                .resizable()
                .scaledToFit()
        } placeholder: {
            Image(systemName: "photo")
        }
        .indicator(.activity)
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
