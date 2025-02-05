//
//  ProductView.swift
//  SampleApp-SwiftUI
//
//  Created by Mohammad Alabed on 04/02/2025.
//

import SwiftUI

struct ProductView: View {
    let thumbnail: String?
    let title: String?
    let price: Double?
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                LazyImage(imageUrlString: thumbnail)
                    .frame(width: 50, height: 50)
                    .accessibilityIdentifier("ProductView.LazyImage")
                VStack(alignment: .leading) {
                    Text(title ?? "no name")
                        .font(.headline)
                        .accessibilityIdentifier("ProductView.title")
                    Text("$\(price ?? 0.0, specifier: "%.2f")")
                        .foregroundColor(.gray)
                        .accessibilityIdentifier("ProductView.price")
                }
            }
        }
    }
}

#Preview {
    ProductView(thumbnail: "", title: "title", price: 12.2)
}
