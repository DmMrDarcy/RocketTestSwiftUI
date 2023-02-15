//
//  AppEnvironment.swift
//  RocketSwiftUIApp
//
//  Created by Dmitriy Lukyanov on 14.02.2023.
//

import UIKit
import Combine

struct AppEnvironment {
    let container: DIContainer
}

extension AppEnvironment {
    static func bootstrap() -> AppEnvironment {
        let appState = Store(AppState())
        let storageRepo = StorageRepo()
        let storageService = StorageService(appState: appState, repo: storageRepo)
        
        let commonService = DIContainer.CommonService(appState: appState, storage: storageService)
        let diContainer = DIContainer(appState: appState, commonService: commonService)

        return AppEnvironment(container: diContainer)
    }
}
