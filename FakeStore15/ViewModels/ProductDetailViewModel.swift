//
//  ProductDetailViewModel.swift
//  FakeStore
//
//  Created by Martin Bucko on 18/11/2024.
//

import Foundation

@MainActor
class ProductDetailViewModel: ObservableObject {
    @Published var product: Product?
    private let productId: Int
    
    init(productId: Int) {
        self.productId = productId
    }
    
    func fetchProduct() async {
        product = try? await NetworkService.shared.fetchProductDetail(productId: productId)
    }
}
