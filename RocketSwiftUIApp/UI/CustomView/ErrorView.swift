//
//  ErrorView.swift
//  RocketSwiftUIApp
//
//  Created by Dmitriy Lukyanov on 15.02.2023.
//

import SwiftUI

struct ErrorView: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            Text("Something went wrong. Please try again later")
                .font(CustomFonts.title2.medium)
                .foregroundColor(.white)
        }
    }
}
