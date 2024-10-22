//
//  ContentView.swift
//  LLoydsTask
//
//  Created by Lakshmi Narasimha on 16/10/24.
//

import SwiftUI

// MARK: - Product List View
struct ContentView: View {
    @StateObject  var productViewModel = ProductViewModel()
    var body: some View {
        NavigationView {
            Group {
                if productViewModel.isLoading {
                    ProgressView(Constants.StringConstants.fetchProducts)
                } else if let error = productViewModel.errorMessage {
                    Text("Error: \(error)")
                        .foregroundColor(.red)
                } else {
                    List(productViewModel.products) { product in
                        ProductRowView(product: product)
                    }
                }
            }
            .onAppear {
                productViewModel.fetchProducts()
            }
            .navigationTitle(Constants.StringConstants.productTitle)
        }
    }
}

// MARK: - Product Row View
struct ProductRowView: View {
    var product: ProductModel
    @StateObject private var productViewModel = ProductViewModel()
    var body: some View {
        HStack {
            NavigationLink(destination: ProductDetailView(productImage: product.image, productTitle: product.title, productPrice: product.price)) {
                // Load Image in Async
                AsyncImage(url: URL(string: product.image)) { image in
                    image.resizable()
                        .frame(width: Constants.StringConstants.imageWidth, height: Constants.StringConstants.imageHeight)
                        .clipShape(Circle())
                } placeholder: {
                    ProgressView()
                }
                VStack(alignment: .leading, spacing: Constants.StringConstants.verticalspacing) {
                    Text(product.title)
                        .font(.headline)
                    Text(product.category.capitalized)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text("$\(product.price, specifier: "%.2f")")
                        .font(.body)
                        .fontWeight(.bold)
                        .foregroundColor(productViewModel.priceColor(for: product.price))
                        .font(.subheadline)
                }
            }
        }
    }
}

// MARK: - Previews
#Preview {
    ContentView()
}
