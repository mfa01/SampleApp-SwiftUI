//
//  ProductViewModelTests.swift
//  SampleApp-SwiftUITests
//
//  Created by Mohammad Alabed on 04/02/2025.
//

import XCTest
@testable import SampleApp_SwiftUI

class ProductViewModelTests: XCTestCase {
    
    var viewModel: ProductViewModel!
    var mockNetworkService: MockNetworkService!
    var mockSession: MockURLSession!
    
    @MainActor
    override func setUpWithError() throws {
        super.setUp()
        mockNetworkService = MockNetworkService()
        mockSession = MockURLSession()
        mockNetworkService.session = mockSession
        viewModel = ProductViewModel(networkService: mockNetworkService)
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        mockNetworkService = nil
        super.tearDown()
    }
    
    @MainActor
    func testFetchProductsSuccess() async {
        let productData = """
        {
            "products": [{
                "id": 1,
                "title": "Test Product",
                "price": 9.99
            }],
            "total": 1,
            "skip": 1,
            "limit": 10
        }
        """.data(using: .utf8)!
        
        mockSession.mockData = productData
        mockSession.mockResponse = nil
        mockSession.mockError = nil
        
        await viewModel.fetchProducts()
        
        XCTAssertEqual(viewModel.products.count, 1)
        XCTAssertEqual(viewModel.products.first?.title, "Test Product")
        XCTAssertNil(viewModel.errorMessage)
    }
    
    @MainActor
    func testFetchProductsFailureWithNetworkError() async {
        mockSession.mockData = nil
        mockSession.mockResponse = nil
        mockSession.mockError = NSError(domain: "TestError", code: 1, userInfo: nil)
        
        await viewModel.fetchProducts()
        
        XCTAssertEqual(viewModel.products.count, 0)
        XCTAssertNotNil(viewModel.errorMessage)
    }
    
    @MainActor
    func testFetchProductsFailureWithDecodingError() async {
        let invalidData = """
        {
            "invalidField": "Invalid"
        }
        """.data(using: .utf8)!
        
        mockSession.mockData = invalidData
        mockSession.mockResponse = nil
        mockSession.mockError = nil
        
        await viewModel.fetchProducts()
        
        XCTAssertEqual(viewModel.products.count, 0)
        XCTAssertNotNil(viewModel.errorMessage)
    }
    
    @MainActor
    func testPaginationWorksCorrectly() async {
        let firstPageData = """
        {
            "products": [{
                "id": 1,
                "title": "Test Product 1",
                "price": 9.99
            }],
            "total": 194,
            "skip": 1,
            "limit": 10
        }
        """.data(using: .utf8)!
        
        let secondPageData = """
        {
            "products": [{
                "id": 2,
                "title": "Test Product 2",
                "price": 19.99
            }],
            "total": 194,
            "skip": 1,
            "limit": 10
        }
        """.data(using: .utf8)!
        
        // Simulate first page fetch
        mockSession.mockData = firstPageData
        mockSession.mockResponse = nil
        mockSession.mockError = nil
        await viewModel.fetchProducts()
        
        XCTAssertEqual(viewModel.products.count, 1)
        XCTAssertEqual(viewModel.products.first?.title, "Test Product 1")
        
        // Simulate second page fetch
        mockSession.mockData = secondPageData
        await viewModel.fetchProducts()
        
        XCTAssertEqual(viewModel.products.count, 2)
        XCTAssertEqual(viewModel.products[1].title, "Test Product 2")
    }
}


