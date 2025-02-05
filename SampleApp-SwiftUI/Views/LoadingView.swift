//
//  LoadingView.swift
//  SampleApp-SwiftUI
//
//  Created by Mohammad Alabed on 04/02/2025.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ProgressView("Loading Products...")
            .padding()
    }
}

#Preview {
    LoadingView()
}
