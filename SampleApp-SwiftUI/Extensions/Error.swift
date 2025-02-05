//
//  Error.swift
//  SampleApp-SwiftUI
//
//  Created by Mohammad Alabed on 04/02/2025.
//

import Foundation

extension Error {
    var userFriendlyMessage: String {
        if let customError = self as? CustomError {
            switch customError {
            case .invalidURL:
                return "Invalid URL"
            case .networkFailure(let description):
                return "Network Error: \(description)"
            case .decodingError:
                return "Failed to decode response"
            case .unknownError:
                return "An unknown error occurred"
            }
        }
        return "Unexpected error: \(self.localizedDescription)"
    }
}
