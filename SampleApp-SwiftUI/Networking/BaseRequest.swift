//
//  BaseRequest.swift
//  SampleApp-SwiftUI
//
//  Created by Mohammad Alabed on 04/02/2025.
//

import Foundation

protocol BaseRequest {
    var additionalHeaders: [String: String] { get }
    var queryItems: [String: String] { get }
    var endpoint: APIEndpoint { get }
    var httpMethod: HttpMethod { get }
}

extension BaseRequest {
    var additionalHeaders: [String: String] { [:]
    }
}
