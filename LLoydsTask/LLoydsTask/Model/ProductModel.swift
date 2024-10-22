//
//  DataModel.swift
//  LLoydsTask
//
//  Created by Lakshmi Narasimha on 16/10/24.
//

import Foundation

// Model to represent product data from API
struct ProductModel: Identifiable, Decodable {
    let id: Int
    let title: String
    let price: Double
    let category: String
    let image: String
}

