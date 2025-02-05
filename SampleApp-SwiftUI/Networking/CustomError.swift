//
//  CustomError.swift
//  SampleApp-SwiftUI
//
//  Created by Mohammad Alabed on 04/02/2025.
//

import Foundation

public enum CustomError: Error {
    case invalidURL
    case networkFailure(description: String)
    case decodingError
    case unknownError
}
