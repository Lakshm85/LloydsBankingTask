//
//  ProductViewModelTests.swift
//  LLoydsTaskTests
//
//  Created by Lakshmi Narasimha on 17/10/24.
//

import XCTest
import Combine
@testable import LLoydsTask

// MARK: - ProductsViewModelTests
class ProductViewModelTests: XCTestCase {
    var viewModel: ProductViewModel!
    var mockNetworkService: MockNetworkService!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        viewModel = ProductViewModel(networkService: mockNetworkService)
        cancellables = []
    }
    
    override func tearDown() {
        viewModel = nil
        mockNetworkService = nil
        cancellables = nil
        super.tearDown()
    }
    
    //Test for fetchProducts
    func testFetchProductsSuccess() {
        // Given
        let product = ProductModel(id: 1, title: Constants.StringConstants.testProductTitle, price: Constants.StringConstants.testProductPrice, category: Constants.StringConstants.testProductCategory, image: Constants.StringConstants.emptyString)
        mockNetworkService.products = [product]
        
        // When
        viewModel.fetchProducts()
        
        // Then
        viewModel.$products
            .dropFirst()
            .sink { products in
                XCTAssertFalse(self.viewModel.isLoading)
                XCTAssertEqual(products.count, 1)
                XCTAssertEqual(products.first?.title, Constants.StringConstants.testProductTitle)
            }
            .store(in: &cancellables)
    }
    
    //Test for productsFailure scenario...
    func testFetchProductsFailure() {
        // Given
        mockNetworkService.error = URLError(.badServerResponse)
        
        // When
        viewModel.fetchProducts()
        
        // Then
        viewModel.$errorMessage
            .sink { errorMessage in
                XCTAssertFalse(self.viewModel.isLoading)
                XCTAssertNotNil(errorMessage)
            }
            .store(in: &cancellables)
    }
    
    //Test for different price ranges
    func testPriceColor() throws {
        XCTAssertEqual(viewModel.priceColor(for: 30), .green)
        XCTAssertEqual(viewModel.priceColor(for: 75), .orange)
        XCTAssertEqual(viewModel.priceColor(for: 150), .red)
    }
}
