//
//  ReviewsView.swift
//  SampleApp-SwiftUI
//
//  Created by Mohammad Alabed on 04/02/2025.
//

import SwiftUI

struct ReviewsView: View {
    var reviews: [Review]
    
    var body: some View {
        Text("Reviews (\(reviews.count))")
            .font(.headline)
            .padding(.top)
        
        ForEach(reviews, id: \.reviewerEmail) { review in
            VStack(alignment: .leading) {
                Text(review.reviewerName)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                HStack {
                    Text("Rating: \(review.rating)")
                    Spacer()
                    Text(review.date)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Text(review.comment)
                    .font(.body)
                    .padding(.top, 4)
            }
            .padding(.top, 8)
        }
    }
}
