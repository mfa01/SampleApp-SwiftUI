//
//  Product.swift
//  SampleApp-SwiftUI
//
//  Created by Mohammad Alabed on 04/02/2025.
//

import Foundation

struct Product: Codable, Identifiable, Equatable {
    let id: Int
    let title, description, category: String?
    let price, discountPercentage, rating: Double?
    let stock: Int?
    let tags: [String]?
    let brand, sku: String?
    let weight: Int?
    let dimensions: Dimensions?
    let warrantyInformation, shippingInformation, availabilityStatus: String?
    let reviews: [Review]?
    let returnPolicy: String?
    let minimumOrderQuantity: Int?
    let meta: Meta?
    let images: [String]?
    let thumbnail: String?
    
    static func ==(lhs: Product, rhs: Product) -> Bool {
        return lhs.id == rhs.id
    }
}
