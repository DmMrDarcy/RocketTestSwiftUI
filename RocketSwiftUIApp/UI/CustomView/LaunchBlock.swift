//
//  LaunchBlock.swift
//  RocketSwiftUIApp
//
//  Created by Dmitriy Lukyanov on 15.02.2023.
//

import SwiftUI

struct LaunchBlock: View {
    let title: String
    let date: String
    let imagePath: String

    var body: some View {
        Group {
            HStack {
                VStack(spacing: 5) {
                    Text(title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(CustomFonts.title3.font)
                        .foregroundColor(.white)
                    
                    Text(date)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                Spacer()
                
                AsyncImage(url: URL(string: imagePath)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 45, height: 45)
            }
            .padding(.vertical, 25)
            .padding(.horizontal, 20)
        }
        .font(CustomFonts.callout.font)
        .foregroundColor(.gray)
        .background(Color("RectColor"))
        .cornerRadius(25, corners: .allCorners)
    }
}
