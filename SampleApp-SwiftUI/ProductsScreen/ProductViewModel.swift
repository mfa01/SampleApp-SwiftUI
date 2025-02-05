//
//  ProductViewModel.swift
//  SampleApp-SwiftUI
//
//  Created by Mohammad Alabed on 04/02/2025.
//

import Combine
import SwiftUI

enum SortOption: String, CaseIterable {
    case titleAscending = "Title ↑"
    case titleDescending = "Title ↓"
    case priceAscending = "Price ↑"
    case priceDescending = "Price ↓"
    case dateAscending = "Date ↑"
    case dateDescending = "Date ↓"
    
    var sortField: SortField {
        switch self {
        case .titleAscending, .titleDescending:
            return .title
        case .priceAscending, .priceDescending:
            return .price
        case .dateAscending, .dateDescending:
            return .date
        }
    }
    
    var sortOrder: SortOrder {
        switch self {
        case .titleAscending, .priceAscending, .dateAscending:
            return .ascending
        case .titleDescending, .priceDescending, .dateDescending:
            return .descending
        }
    }
}


enum SortField: String {
    case title = "title"
    case price = "price"
    case date = "date"
}

enum SortOrder: String {
    case ascending = "asc"
    case descending = "desc"
}

@MainActor
class ProductViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    @Published var searchText: String = ""
    @Published var sortOption: SortOption = .dateDescending
    var sortOrder: SortOrder = .descending
    var sortField: SortField = .date
    
    private var cancellables = Set<AnyCancellable>()
    
    private var currentPage = 1
    private var isLastPage = false
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol = NetworkService.shared) {
        self.networkService = networkService
        setupSearchThrottling()
    }
    
    // Debounced Search Handler
    private func setupSearchThrottling() {
        $searchText
            .removeDuplicates()
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .dropFirst() // Ignore the first emission on initialization
            .sink { [weak self] newText in
                Task { await self?.updateSearchText(searchText: newText) }
            }
            .store(in: &cancellables)
        
        $sortOption
            .dropFirst() // Ignore the first emission on initialization
            .sink { [weak self] _ in
                Task { await self?.applySorting() }
            }
            .store(in: &cancellables)
    }
    
    func updateSearchText(searchText: String) async {
        self.searchText = searchText
        reset()
        await fetchProducts()
    }
    
    func fetchProducts() async {
        guard !isLoading, !isLastPage else { return }
        
        isLoading = true
        errorMessage = nil
        
        do {
            let fetchedProducts: ProductResponse = try await networkService.fetch(apiRequest: buildRequest())
            let newProducts = fetchedProducts.products
            
            if currentPage == 1 {
                products = newProducts
            } else {
                products.append(contentsOf: newProducts)
            }
            
            currentPage += 1
            isLastPage = fetchedProducts.total <= products.count
        } catch {
            self.errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    private func buildRequest() -> BaseRequest {
        if !searchText.isEmpty {
            return ProductsSearchRequest(
                searchText: searchText,
                limit: APIConstants.productsPageSize,
                skip: (currentPage - 1) * APIConstants.productsPageSize,
                sortOrder: sortOrder,
                sortField: sortField
            )
        } else {
            return FetchProductsRequest(
                limit: APIConstants.productsPageSize,
                skip: (currentPage - 1) * APIConstants.productsPageSize,
                sortOrder: sortOrder,
                sortField: sortField)
        }
    }
    
    private func applySorting() async {
        sortField = sortOption.sortField
        sortOrder = sortOption.sortOrder
        
        await refreshProducts()
    }
    
    private func reset() {
        isLastPage = false
        currentPage = 1
        products.removeAll()
        isLoading = false
        errorMessage = nil
    }
    
    func refreshProducts() async {
        reset()
        await fetchProducts()
    }
}
