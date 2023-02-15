//
//  Helpers.swift
//  RocketSwiftUIApp
//
//  Created by Dmitriy Lukyanov on 15.02.2023.
//

import Foundation

func dateConverter(_ responseDate: String) -> String {
    var isoDate = ""
    
    if responseDate.count > 10 {
        let indexDate = responseDate.range(of: "T", options: .backwards)?.lowerBound
        let localDate = indexDate.map(responseDate.substring(to:))!
        isoDate = localDate + "T10:00:00+0000"
    } else {
        isoDate = responseDate + "T10:00:00+0000"
    }
    
    let isoDateFormatter = ISO8601DateFormatter()
    let date = isoDateFormatter.date(from: isoDate)!
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "d MMMM, yyyy"
    
    return dateFormatter.string(from: date)
}

func costConverter(_ responseCost: Int) -> String {
    var cost = 0.0
    let doubleResponseCost = Double(responseCost)
    
    if doubleResponseCost > 1000000 {
        cost = doubleResponseCost/1000000
        return "$ \(cost) млн"
    }
    
    cost = doubleResponseCost/100000
    return "$ \(cost) тыс"
}
