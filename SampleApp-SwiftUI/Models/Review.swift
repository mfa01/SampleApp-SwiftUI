//
//  Review.swift
//  SampleApp-SwiftUI
//
//  Created by Mohammad Alabed on 04/02/2025.
//

import Foundation

struct Review: Codable {
    let rating: Int
    let comment, date, reviewerName, reviewerEmail: String
}
