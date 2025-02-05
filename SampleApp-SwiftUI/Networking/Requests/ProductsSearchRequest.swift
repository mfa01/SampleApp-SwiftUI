//
//  ProductsSearchRequest.swift
//  SampleApp-SwiftUI
//
//  Created by Mohammad Alabed on 05/02/2025.
//

import Foundation

struct ProductsSearchRequest: BaseRequest {
    let endpoint: APIEndpoint = .search
    var httpMethod: HttpMethod = .get
    let searchText: String
    let limit: Int
    let skip: Int
    let sortOrder: SortOrder
    let sortField: SortField
    
    var queryItems: [String : String] {
        [
            "limit": String(limit),
            "skip": String(skip),
            "q": searchText,
            "sortBy": sortField.rawValue,
            "order": sortOrder.rawValue
        ]
    }
}
