//
//  DeviceViewModel.swift
//  LLoydsTask
//
//  Created by Lakshmi Narasimha on 16/10/24.
//

import Foundation
import Combine
import SwiftUI

// MARK: ViewModel to handle data fetching
class ProductViewModel: ObservableObject {
    @Published var products: [ProductModel] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private var cancellables = Set<AnyCancellable>()
    private let networkService: NetworkServiceProtocol
    
    // Dependency Injection for easier testing and flexibility
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    //MARK: Fetch products...
    func fetchProducts(limit: Int = Constants.StringConstants.productsCount) {
        self.isLoading = true
        networkService.fetchProducts(limit: limit)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] products in
                self?.products = products
            })
            .store(in: &cancellables)
    }
    
    //MARK: Helper function to get color based on price
    func priceColor(for price: Double) -> Color {
        if price < Constants.StringConstants.lowPrice {
            return .green
        } else if price < Constants.StringConstants.mediumPrice {
            return .orange
        } else {
            return .red
        }
    }
}
