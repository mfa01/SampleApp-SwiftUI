//
//  ProductDetailView.swift
//  SampleApp-SwiftUI
//
//  Created by Mohammad Alabed on 04/02/2025.
//

import SwiftUI

struct ProductDetailsView: View {
    var product: Product
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                LazyImage(imageUrlString: product.images?.first)
                    .frame(maxWidth: .infinity, idealHeight: 300)
                TitleText(title: product.title ?? "No title")
                
                HStack {
                    Text("$\(product.price ?? 0.0, specifier: "%.2f")")
                        .font(.title2)
                        .foregroundColor(.green)
                    Spacer()
                    if let discountPercentage = product.discountPercentage {
                        Text("-\(discountPercentage, specifier: "%.2f")%")
                            .foregroundColor(.red)
                            .font(.title2)
                    }
                }
                
                Text(product.description ?? "No description available")
                    .font(.body)
                    .padding(.top, 8)
                    .foregroundColor(.gray)
                
                Group {
                    Divider()
                    ProductDetailRow(label: "Category", value: product.category ?? "N/A")
                    ProductDetailRow(label: "Brand", value: product.brand ?? "N/A")
                    ProductDetailRow(label: "SKU", value: product.sku ?? "N/A")
                    ProductDetailRow(label: "Weight", value: "\(product.weight ?? 0) kg")
                    ProductDetailRow(label: "Dimensions", value: "\(product.dimensions?.width ?? 0) x \(product.dimensions?.height ?? 0) x \(product.dimensions?.depth ?? 0) cm")
                    ProductDetailRow(label: "Warranty", value: product.warrantyInformation ?? "No warranty information")
                    ProductDetailRow(label: "Shipping", value: product.shippingInformation ?? "No shipping info")
                }
                
                VStack(alignment: .leading) {
                    Text("Availability: \(product.availabilityStatus ?? "N/A")")
                        .font(.headline)
                    Text("Stock: \(product.stock ?? 0) items")
                        .font(.subheadline)
                }
                .padding(.top)
                
                if let reviews = product.reviews, !reviews.isEmpty {
                    ReviewsView(reviews: reviews)
                }
                
                if let returnPolicy = product.returnPolicy {
                    Text("Return Policy: \(returnPolicy)")
                        .font(.body)
                        .foregroundColor(.gray)
                        .padding(.top)
                }
                
                Spacer()
            }
            .padding()
            .accessibilityIdentifier("ProductDetailsView")
        }
        .navigationTitle("Product Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ProductDetailsView(product: Product(
        id: 1,
        title: "Essence Mascara Lash Princess",
        description: "The Essence Mascara Lash Princess is a popular mascara known for its volumizing and lengthening effects. Achieve dramatic lashes with this long-lasting and cruelty-free formula.",
        category: "beauty",
        price: 9.99,
        discountPercentage: 7.17,
        rating: 4.94,
        stock: 5,
        tags: ["beauty", "mascara"],
        brand: "Essence",
        sku: "RCH45Q1A",
        weight: 2,
        dimensions: Dimensions(width: 23.17, height: 14.43, depth: 28.01),
        warrantyInformation: "1 month warranty",
        shippingInformation: "Ships in 1 month",
        availabilityStatus: "Low Stock",
        reviews: [
            Review(rating: 2, comment: "Very unhappy with my purchase!", date: "2024-05-23T08:56:21.618Z", reviewerName: "John Doe", reviewerEmail: "hello@gmail.com"),
            Review(rating: 2, comment: "Not as described!", date: "2024-05-23T08:56:21.618Z", reviewerName: "Nolan Gonzalez", reviewerEmail: "hello@gmail.com"),
            Review(rating: 5, comment: "Very satisfied!", date: "2024-05-23T08:56:21.618Z", reviewerName: "Scarlett Wright", reviewerEmail: "hello@gmail.com")
        ],
        returnPolicy: "30 days return policy",
        minimumOrderQuantity: 24,
        meta: Meta(createdAt: "2024-05-23T08:56:21.618Z", updatedAt: "2024-05-23T08:56:21.618Z", barcode: "9164035109868", qrCode: "https://assets.dummyjson.com/public/qr-code.png"),
        images: ["https://cdn.dummyjson.com/products/images/beauty/Essence%20Mascara%20Lash%20Princess/1.png"],
        thumbnail: "https://cdn.dummyjson.com/products/images/beauty/Essence%20Mascara%20Lash%20Princess/thumbnail.png"
    ))
}
