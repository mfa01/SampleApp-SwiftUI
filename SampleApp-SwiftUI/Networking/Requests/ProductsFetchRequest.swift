//
//  FetchProductsRequest.swift
//  SampleApp-SwiftUI
//
//  Created by Mohammad Alabed on 04/02/2025.
//

import Foundation

struct FetchProductsRequest: BaseRequest {
    let endpoint: APIEndpoint = .products
    let limit: Int
    let skip: Int
    var httpMethod: HttpMethod = .get
    let sortOrder: SortOrder
    let sortField: SortField
    
    var queryItems: [String : String] {
        [
            "limit": String(limit),
            "skip": String(skip),
            "sortBy": sortField.rawValue,
            "order": sortOrder.rawValue
        ]
    }
}
