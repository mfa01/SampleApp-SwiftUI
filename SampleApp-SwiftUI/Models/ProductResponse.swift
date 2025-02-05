//
//  ProductResponse.swift
//  SampleApp-SwiftUI
//
//  Created by Mohammad Alabed on 04/02/2025.
//

import Foundation

struct ProductResponse: Codable {
    let products: [Product]
    let total: Int
    let skip: Int
    let limit: Int
}
