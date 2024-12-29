//
//  BackgroundView.swift
//  swiftui-weather-app
//
//  Created by Raul CM on 22.12.2024.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        LinearGradient(
            colors: [.blue, .cyan, .white],
            startPoint: .topLeading,
            endPoint: .bottomLeading
        ).ignoresSafeArea(.all)
    }
}

#Preview {
    BackgroundView()
}
