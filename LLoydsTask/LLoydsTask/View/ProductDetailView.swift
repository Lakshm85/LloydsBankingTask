//
//  ProductDetailView.swift
//  LLoydsTask
//
//  Created by Admin on 17/10/24.
//

import SwiftUI

//MARK: DetailsView of Products
struct ProductDetailView: View {
    @StateObject var viewModel = ProductViewModel()
    let productImage: String
    let productTitle: String
    let productPrice: Double
    var body: some View {
        VStack(spacing:Constants.StringConstants.verticalspacing){
            AsyncImage(url: URL(string: productImage)) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: Constants.StringConstants.WIDTH_THREE_HUNDRED, height: Constants.StringConstants.WIDTH_THREE_HUNDRED)
            } placeholder: {
                ProgressView()
            }
            Text(productTitle)
                .font(.title2)
                .multilineTextAlignment(.center)
            Text("$\(productPrice, specifier: "%.2f")")
                .font(.title3)
                .foregroundColor(viewModel.priceColor(for: productPrice))
        }
    }
}
