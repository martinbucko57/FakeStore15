//
//  ProductsViewModel.swift
//  FakeStore
//
//  Created by Martin Bucko on 18/11/2024.
//

import Foundation

@MainActor
class ProductsViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var categories: [String] = []
    @Published var selectedCategory: String? = nil
    @Published var showFilter: Bool = false
    @Published var isLoading: Bool = false
    
    func fetchData() async {
        isLoading = true
        
        products = (try? await NetworkService.shared.fetchProducts(category: selectedCategory)) ?? []
        categories = (try? await NetworkService.shared.fetchCategories()) ?? []
        
        isLoading = false
    }
    
    func filterTapped() {
        showFilter.toggle()
    }
    
    func selectCategory(_ category: String) {
        selectedCategory = category
    }
    
    func resetCategory() {
        selectedCategory = nil
    }
}
