//
//  ErrorView.swift
//  RocketSwiftUIApp
//
//  Created by Dmitriy Lukyanov on 15.02.2023.
//

import SwiftUI

struct ErrorView: View {
    let error: NetworkError?
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                Text("Something went wrong. Please try again later")
                    .font(CustomFonts.title2.medium)
                    .foregroundColor(.white)
                    .padding(.bottom, 20)
                
                Text("Error: \(error.debugDescription)")
                    .font(CustomFonts.callout.medium)
                    .foregroundColor(.white)
            }
            
            
        }
    }
}
