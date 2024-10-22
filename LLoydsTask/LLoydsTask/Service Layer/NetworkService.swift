//
//  APIService.swift
//  LLoydsTask
//
//  Created by Lakshmi Narasimha on 22/10/24.
//

import Foundation
import Combine


//MARK: Network Service Protocol for Mocking
protocol NetworkServiceProtocol {
    func fetchProducts(limit: Int) -> AnyPublisher<[ProductModel], Error>
}

// MARK: - Network Service
class NetworkService: NetworkServiceProtocol {
    private var cancellables = Set<AnyCancellable>()
    
    // Fetch products with Combine Framework...
    func fetchProducts(limit: Int) -> AnyPublisher<[ProductModel], Error> {
        let url = URL(string: "\(Constants.StringConstants.productsUrl)\(limit)")!
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [ProductModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
