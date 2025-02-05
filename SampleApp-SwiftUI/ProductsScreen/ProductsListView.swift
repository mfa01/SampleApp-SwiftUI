//
//  ProductsListView.swift
//  SampleApp-SwiftUI
//
//  Created by Mohammad Alabed on 04/02/2025.
//

import SwiftUI

import SwiftUI

struct ProductsListView: View {
    let products: [Product]
    let isLoading: Bool
    let fetchMore: () async -> Void
    let refresh: () async -> Void
    
    var body: some View {
        List(products) { product in
            NavigationLink(destination: ProductDetailsView(product: product)) {
                ProductView(thumbnail: product.thumbnail, title: product.title, price: product.price)
                    .onAppear {
                        if product == products.last, !isLoading {
                            Task {
                                await fetchMore()
                            }
                        }
                    }
            }
        }
        .refreshable {
            await refresh()
        }
    }
}

#Preview {
    ProductsListView(products: [], isLoading: false, fetchMore: { }, refresh: {
        
    })
}
