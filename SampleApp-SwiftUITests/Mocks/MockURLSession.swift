//
//  MockURLSession.swift
//  SampleApp-SwiftUITests
//
//  Created by Mohammad Alabed on 04/02/2025.
//

import Foundation
@testable import SampleApp_SwiftUI

protocol URLSessionProtocol {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

// Default URLSession implementation for real network calls
extension URLSession: URLSessionProtocol {
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        return try await self.data(for: request, delegate: nil)
    }
}

class MockURLSession: URLSessionProtocol {
    var mockData: Data?
    var mockResponse: URLResponse?
    var mockError: Error?

    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        if let error = mockError {
            throw error
        }
        
        guard let data = mockData else {
            throw CustomError.networkFailure(description: "No data")
        }
        
        let response = mockResponse ?? HTTPURLResponse(
            url: request.url!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!

        return (data, response)
    }
}
