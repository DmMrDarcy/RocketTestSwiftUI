//
//  StorageService.swift
//  RocketSwiftUIApp
//
//  Created by Dmitriy Lukyanov on 15.02.2023.
//

import Foundation

class StorageService {
    private let appState: Store<AppState>
    private var repo: StorageRepoProtocol
    private var cancelBag = CancelBag()
    
    init(appState: Store<AppState>, repo: StorageRepoProtocol) {
        self.appState = appState
        self.repo = repo

        environmentRegistrationLoad()
        installObservers()
    }
    
    private func environmentRegistrationLoad() {
        appState[\.appProcess.heightRocket] = repo.heightRocket
        appState[\.appProcess.diameterRocket] = repo.diameterRocket
        appState[\.appProcess.massRocket] = repo.massRocket
        appState[\.appProcess.weightsRocket] = repo.weightsRocket
    }
    
    private func installObservers() {
        cancelBag.collect {
            appState.map(\.appProcess.heightRocket)
                .removeDuplicates()
                .dropFirst()
                .sink { [unowned self] in
                    repo.heightRocket = $0
                }
            
            appState.map(\.appProcess.diameterRocket)
                .removeDuplicates()
                .dropFirst()
                .sink { [unowned self] in
                    repo.diameterRocket = $0
                }
            
            appState.map(\.appProcess.massRocket)
                .removeDuplicates()
                .dropFirst()
                .sink { [unowned self] in
                    repo.massRocket = $0
                }
            
            appState.map(\.appProcess.weightsRocket)
                .removeDuplicates()
                .dropFirst()
                .sink { [unowned self] in
                    repo.weightsRocket = $0
                }
        }
    }
}
