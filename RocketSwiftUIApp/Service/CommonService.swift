//
//  CommonService.swift
//  RocketSwiftUIApp
//
//  Created by Dmitriy Lukyanov on 14.02.2023.
//

import Alamofire
import Combine

protocol CommonServiceProtocol: AnyObject {
    func getRockets() -> AnyPublisher<[RocketModel], Error>
    func getLaunchs(rocketId: String) -> AnyPublisher<[LaunchModel], Error>
}

extension DIContainer {
    class CommonService: CommonServiceProtocol {
        
        private let appState: Store<AppState>
        private let storage: StorageService
        private var cancelBag = CancelBag()
        
        init(appState: Store<AppState>, storage: StorageService) {
            self.appState = appState
            self.storage = storage
        }
        
        func getRockets() -> AnyPublisher<[RocketModel], Error> {
            return Future({ [weak self] promise  in
                guard let self = self else { return }
                
                AF.request("\(Config.baseUrl)/\(Config.apiCall.rockets)")
                    .validate()
                    .responseDecodable(of: [RocketModel].self) { response in
                        switch response.result {
                        case .success(let value):
                            promise(.success(value))
                            
                        case .failure(let error):
                            print("Request error = \(error)")
                            promise(.failure(error))
                        }
                    }
            }).eraseToAnyPublisher()
        }
        
        func getLaunchs(rocketId: String) -> AnyPublisher<[LaunchModel], Error> {
            return Future({ [weak self] promise  in
                guard let self = self else { return }
                
                AF.request("\(Config.baseUrl)/\(Config.apiCall.launches)")
                    .validate()
                    .responseDecodable(of: [LaunchModel].self) { response in
                        switch response.result {
                        case .success(let value):
                            var launchs: [LaunchModel] = []
                            
                            launchs = value.filter({ item in
                                item.rocket == rocketId
                            })
                            
                            promise(.success(launchs))
                            
                        case .failure(let error):
                            print("Request error = \(error)")
                            promise(.failure(error))
                        }
                    }
            }).eraseToAnyPublisher()
        }
        
        static let stub: CommonService = {
            let appState = Store(AppState())
            let repo = StorageRepo()
            let storageService = StorageService(appState: appState, repo: repo)
            
            return CommonService(appState: .init(.preview), storage: storageService)
        }()
    }
}
