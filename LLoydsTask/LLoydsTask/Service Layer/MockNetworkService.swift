//
//  MockNetworkService.swift
//  LLoydsTaskTests
//
//  Created by Lakshmi Narasimha on 22/10/24.
//

import Combine
import Foundation

class MockNetworkService: NetworkServiceProtocol {
    var products: [ProductModel] = []
    var error: Error? = nil
    
    // Fetch products...
    func fetchProducts(limit: Int) -> AnyPublisher<[ProductModel], any Error> {
        if let error = error {
            return Fail(error: error).eraseToAnyPublisher()
        } else {
            return Just(products)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
}
