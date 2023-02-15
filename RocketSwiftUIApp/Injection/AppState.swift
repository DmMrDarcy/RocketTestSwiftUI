//
//  AppState.swift
//  RocketSwiftUIApp
//
//  Created by Dmitriy Lukyanov on 14.02.2023.
//

import SwiftUI
import Combine

struct AppState: Equatable {
    var routing = Routing()
    var appProcess = Process()
}

extension AppState {
    struct Routing: Equatable {
        var appCurrentState: RoutingModel = .rocket
    }
}

extension AppState {
    struct Process: Equatable {
        var heightRocket: LongUnitsModel = .feat
        var diameterRocket: LongUnitsModel = .feat
        var massRocket: MassUnitsModel = .kg
        var weightsRocket: MassUnitsModel = .lb
    }
}

func == (lhs: AppState, rhs: AppState) -> Bool {
    lhs.routing == rhs.routing
        && lhs.appProcess == rhs.appProcess
}

extension AppState {
    static var preview: AppState {
        let state = AppState()
        return state
    }
}
