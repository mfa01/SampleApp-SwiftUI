//
//  MockNetworkService.swift
//  SampleApp-SwiftUITests
//
//  Created by Mohammad Alabed on 04/02/2025.
//

import Foundation
@testable import SampleApp_SwiftUI

class MockNetworkService: NetworkServiceProtocol {
    var session: URLSessionProtocol
    
    init(session: URLSessionProtocol = MockURLSession()) {
        self.session = session
    }
    
    func fetch<T: Decodable>(apiRequest: BaseRequest) async throws -> T {
        guard let request = NetworkService.shared.buildRequest(from: apiRequest) else {
            throw CustomError.invalidURL
        }
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw CustomError.networkFailure(description: "Invalid response: \(response)")
        }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw CustomError.decodingError
        }
    }
}
