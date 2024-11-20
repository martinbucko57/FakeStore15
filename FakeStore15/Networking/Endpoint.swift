//
//  Endpoint.swift
//  FakeStore
//
//  Created by Martin Bucko on 18/11/2024.
//

import Foundation

enum Endpoint {
    case products(category: String?)
    case productDetail(productId: Int)
    case categories
    
    private var baseURL: String { return "https://fakestoreapi.com" }
    
    var path: String {
        switch self {
        case .products(let category):
            var path: String = "/products"
            
            if let encodedCategory = category?.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) {
                path.append("/category/\(encodedCategory)")
            }
            
            return path
        case .productDetail(let productId): 
            return "/products/\(productId)"
        case .categories: 
            return "/products/categories"
        }
    }
    
    var url: URL? { URL(string: baseURL + path) }
}
