//
//  NetworkService.swift
//  FakeStore
//
//  Created by Martin Bucko on 18/11/2024.
//

import Foundation
import Alamofire

actor NetworkService {
    
    static let shared = NetworkService()
    private init() {}
    
    func fetchProducts(category: String? = nil) async throws -> [Product] {
        try await sendRequest(.products(category: category))
    }
    
    func fetchProductDetail(productId: Int) async throws -> Product {
        try await sendRequest(.productDetail(productId: productId))
    }
    
    func fetchCategories() async throws -> [String] {
        try await sendRequest(.categories)
    }
    
    private func sendRequest<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        guard let url = endpoint.url else {
            throw AFError.invalidURL(url: endpoint.path)
        }
        
        return try await AF.request(url)
            .validate()
            .serializingDecodable(T.self)
            .value
    }
}
