//
//  ProductsScreen.swift
//  SampleApp-SwiftUI
//
//  Created by Mohammad Alabed on 04/02/2025.
//

import SwiftUI

struct ProductsScreen: View {
    @StateObject private var viewModel = ProductViewModel()
    
    private var canShowLoadingView: Bool {
        viewModel.isLoading && viewModel.products.isEmpty
    }
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $viewModel.searchText)
                Picker("Sort by", selection: $viewModel.sortOption) {
                    ForEach(SortOption.allCases, id: \.self) { option in
                        Text(option.rawValue).tag(option)
                    }
                }
                if canShowLoadingView {
                    LoadingView()
                } else if let errorMessage = viewModel.errorMessage {
                    ErrorView(errorMessage: errorMessage) {
                        fetchProducts()
                    }
                } else {
                    ProductsListView(
                        products: viewModel.products,
                        isLoading: viewModel.isLoading
                    ) {
                        fetchProducts()
                    } refresh: {
                        Task {
                            await viewModel.refreshProducts()
                        }
                    }
                }
                Spacer()
            }
            .navigationTitle("Products")
            .task {
                fetchProducts()
            }
        }
    }
    
    private func fetchProducts() {
        Task {
            await viewModel.fetchProducts()
        }
    }
}

#Preview {
    ProductsScreen()
}
