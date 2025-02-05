//
//  NetworkServiceTests.swift
//  SampleApp-SwiftUITests
//
//  Created by Mohammad Alabed on 04/02/2025.
//

import XCTest
@testable import SampleApp_SwiftUI

class NetworkServiceTests: XCTestCase {
    
    var networkService: MockNetworkService!
    var mockSession: MockURLSession!
    
    override func setUpWithError() throws {
        super.setUp()
        networkService = MockNetworkService()
        mockSession = MockURLSession()
        networkService.session = mockSession
    }
    
    override func tearDownWithError() throws {
        networkService = nil
        mockSession = nil
        super.tearDown()
    }
    
    func testFetchProductsSuccess() async {
        let productData = """
        {
            "products": [{
                "id": 1,
                "title": "Test Product",
                "price": 9.99
            }],
            "total": 194,
            "skip": 1,
            "limit": 10
        }
        """.data(using: .utf8)!
        
        mockSession.mockData = productData
        mockSession.mockResponse = nil
        mockSession.mockError = nil
        
        do {
            let request = FetchProductsRequest(limit: 10, skip: 1, sortOrder: .descending, sortField: .date)
            let response: ProductResponse = try await networkService.fetch(apiRequest: request)
            XCTAssertEqual(response.products.count, 1)
            XCTAssertEqual(response.products.first?.title, "Test Product")
        } catch {
            XCTFail("Expected successful response, but got error: \(error)")
        }
    }
    
    func testFetchProductsFailure() async {
        mockSession.mockData = nil
        mockSession.mockResponse = nil
        mockSession.mockError = NSError(domain: "TestError", code: 1, userInfo: nil)
        
        do {
            let request = FetchProductsRequest(limit: 10, skip: 1, sortOrder: .descending, sortField: .date)
            let _: ProductResponse = try await networkService.fetch(apiRequest: request)
            XCTFail("Expected error, but got successful response")
        } catch {
            XCTAssertNotNil(error)
        }
    }
}
