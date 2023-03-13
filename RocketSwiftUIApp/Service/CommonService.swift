//
//  CommonService.swift
//  RocketSwiftUIApp
//
//  Created by Dmitriy Lukyanov on 14.02.2023.
//

import Alamofire
import Combine
import UIKit

protocol CommonServiceProtocol: AnyObject {
    func getRockets() -> AnyPublisher<[RocketModel], NetworkError>
    func getLaunchs() -> AnyPublisher<[LaunchModel], NetworkError>
}

extension DIContainer {
    class CommonService: CommonServiceProtocol {
        
        private let appState: Store<AppState>
        private let apiManager: APIManager
        private let storage: StorageService
        private var cancelBag = CancelBag()
        
        init(appState: Store<AppState>, apiManager: APIManager, storage: StorageService) {
            self.appState = appState
            self.apiManager = apiManager
            self.storage = storage
        }
        
        func getRockets() -> AnyPublisher<[RocketModel], NetworkError>  {
            let publisher: AnyPublisher<[RocketModel], NetworkError> =
            apiManager.call(apiMethod: .rockets)
            
            return publisher
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        }
        
        func getLaunchs() -> AnyPublisher<[LaunchModel], NetworkError>  {
            let publisher: AnyPublisher<[LaunchModel], NetworkError> =
            apiManager.call(apiMethod: .launches)
            
            return publisher
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        }
        
        static let stub: CommonService = {
            let repo = StorageRepo()
            let apiManager = APIManager()
            let storageService = StorageService(appState: .init(.preview), repo: repo)
            
            return CommonService(appState: .init(.preview), apiManager: apiManager, storage: storageService)
        }()
    }
}
