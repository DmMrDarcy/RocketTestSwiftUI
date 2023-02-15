//
//  StepBlock.swift
//  RocketSwiftUIApp
//
//  Created by Dmitriy Lukyanov on 15.02.2023.
//

import SwiftUI

struct StepBlock: View {
    let title: String
    let engines: String
    let fuelAmountTons: String
    let burnTimeSEC: String
    
    var body: some View {
        Group {
            Text(title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(CustomFonts.title3.bold)
                .foregroundColor(.white)
            
            HStack {
                Text("Number of engines")
                Spacer()
                Text(engines)
                    .font(CustomFonts.callout.font)
                    .foregroundColor(.white)
            }
            
            HStack {
                Text("Fuel quantity")
                Spacer()
                Text(fuelAmountTons + " ton")
                    .font(CustomFonts.callout.font)
                    .foregroundColor(.white)
            }
            
            HStack {
                Text("Burn time")
                Spacer()
                Text(burnTimeSEC + " sec")
                    .font(CustomFonts.callout.font)
                    .foregroundColor(.white)
            }
        }
        .font(CustomFonts.callout.light)
        .foregroundColor(.gray)
        .padding(.vertical, 8)
    }
}
