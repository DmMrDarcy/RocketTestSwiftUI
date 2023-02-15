//
//  ProcessModel.swift
//  RocketSwiftUIApp
//
//  Created by Dmitriy Lukyanov on 14.02.2023.
//

import Foundation

enum RoutingModel {
    case rocket
}

enum LongUnitsModel: Codable, Equatable {
    case meters
    case feat
}

enum MassUnitsModel: Codable, Equatable {
    case kg
    case lb
}

enum TypeRocketParamsModel: Codable, Equatable {
    case height
    case diameter
    case mass
    case weights
}
