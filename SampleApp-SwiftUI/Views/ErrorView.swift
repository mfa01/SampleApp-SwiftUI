//
//  ErrorView.swift
//  SampleApp-SwiftUI
//
//  Created by Mohammad Alabed on 04/02/2025.
//

import SwiftUI

struct ErrorView: View {
    let errorMessage: String
    let onRetry: () async -> Void

    var body: some View {
        VStack {
            Text(errorMessage)
                .foregroundColor(.red)
                .multilineTextAlignment(.center)
                .padding()
            
            Button("Retry") {
                Task {
                    await onRetry()
                }
            }
            .buttonStyle(.borderedProminent)
            Spacer()
        }
    }
}

#Preview {
    ErrorView(errorMessage: "Something went wrong", onRetry: {
    })
}

