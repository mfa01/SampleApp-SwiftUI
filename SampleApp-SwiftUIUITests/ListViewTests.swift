//
//  ListViewTests.swift
//  SampleApp-SwiftUIUITests
//
//  Created by Mohammad Alabed on 05/02/2025.
//

import XCTest

final class ListViewTests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        app.launch()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testListItemHasMetaData() throws {
        XCTAssert(app.staticTexts["ProductView.price"].waitForExistence(timeout: 10), "List item has not price")
        XCTAssert(app.staticTexts["ProductView.title"].waitForExistence(timeout: 10), "List Item has no title")
    }
    
    func testSearchBarReturningResults() throws {
        let searchBar = app.textFields["SearchBar"]
        XCTAssertTrue(searchBar.waitForExistence(timeout: 5), "Search bar not found")

        searchBar.tap()
        searchBar.typeText("iPhone")
        
        let firstProduct = app.images["ProductView.LazyImage"]
        XCTAssertTrue(firstProduct.waitForExistence(timeout: 5), "Search results did not load")
    }
    
    func testListCanScroll() throws {
        let firstProduct = app.images["ProductView.LazyImage"].firstMatch
        XCTAssertTrue(firstProduct.waitForExistence(timeout: 5), "List did not load")
        let initialY = firstProduct.frame.origin.y
        firstProduct.swipeUp()
        let newY = firstProduct.frame.origin.y
        XCTAssertNotEqual(initialY, newY, "List cant scroll")
    }
    
    func testCanNavigateToDetailsScreen() throws {
        let firstProduct = app.images["ProductView.LazyImage"].firstMatch
        XCTAssertTrue(firstProduct.waitForExistence(timeout: 5), "List did not load")
        firstProduct.tap()
        XCTAssert(app.staticTexts["ProductDetailsView"].waitForExistence(timeout: 5), "cant navigate to ProductDetailsView")
    }
}
