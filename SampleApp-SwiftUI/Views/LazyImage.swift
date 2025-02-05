//
//  LazyImage.swift
//  SampleApp-SwiftUI
//
//  Created by Mohammad Alabed on 04/02/2025.
//

import SwiftUI

struct LazyImage: View {
    let imageUrlString: String?
    let cornerRadius: CGFloat = 8
    var body: some View {
        let imageUrl = URL(string: imageUrlString ?? "")
        AsyncImage(url: imageUrl) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(cornerRadius)
            case .failure:
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(cornerRadius)
            @unknown default:
                EmptyView()
            }
        }
    }
}

#Preview {
    LazyImage(imageUrlString: "")
}
