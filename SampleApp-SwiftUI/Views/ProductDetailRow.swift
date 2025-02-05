//
//  ProductDetailRow.swift
//  SampleApp-SwiftUI
//
//  Created by Mohammad Alabed on 04/02/2025.
//

import SwiftUI

struct ProductDetailRow: View {
    var label: String
    var value: String
    
    var body: some View {
        HStack {
            Text(label)
                .font(.headline)
                .foregroundColor(.gray)
            Spacer()
            Text(value)
                .font(.body)
                .multilineTextAlignment(.trailing)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    ProductDetailRow(label: "label", value: "value")
}
