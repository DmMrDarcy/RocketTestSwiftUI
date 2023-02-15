//
//  DependencyInjector.swift
//  RocketSwiftUIApp
//
//  Created by Dmitriy Lukyanov on 14.02.2023.
//

import SwiftUI
import Combine

struct DIContainer: EnvironmentKey {
    
    let appState: Store<AppState>
    let commonServices: DIContainer.CommonService

    static var defaultValue: Self { Self.default }
    
    private static let `default` = DIContainer(
        appState: AppState.preview,
        commonService: .stub
    )

    init(appState: Store<AppState>,
         commonService: CommonService) {
        self.appState = appState
        self.commonServices = commonService
    }

    init(appState: AppState,
         commonService: CommonService) {
        self.init(appState: Store(appState), commonService: commonService)
    }
    
}

extension DIContainer {
    static var preview: Self {
        self.init(appState: AppState.preview,
                  commonService: .stub)
    }
}
