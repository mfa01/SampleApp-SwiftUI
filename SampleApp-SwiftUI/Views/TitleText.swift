//
//  TitleText.swift
//  SampleApp-SwiftUI
//
//  Created by Mohammad Alabed on 04/02/2025.
//

import SwiftUI

struct TitleText: View {
    var title: String
    var body: some View {
        Text(title)
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding(.top)
    }
}

#Preview {
    TitleText(title: "No Title")
}
