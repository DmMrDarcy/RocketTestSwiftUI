//
//  LoadingView.swift
//  RocketSwiftUIApp
//
//  Created by Dmitriy Lukyanov on 15.02.2023.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                .scaleEffect(3)
        }
    }
}
