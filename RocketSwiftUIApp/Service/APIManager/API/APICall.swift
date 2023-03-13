//
//  APICall.swift
//  RocketSwiftUIApp
//
//  Created by Dmitriy Lukyanov on 07.03.2023.
//

import Foundation
import Alamofire

protocol APICall {
    var parameters: RequestParameters {get}
    var path: String {get}
    var httpMethod: HTTPMethod {get}
    func createURLConvertible(baseURL: URL) -> String
}

extension APICall {
    func createURLConvertible(baseURL: URL) -> String {
        return "\(baseURL)/\(path)"
    }
}

enum APIMethods {
    case rockets
    case launches
}

extension APIMethods: APICall {
    var parameters: RequestParameters {
        switch self {
        case .rockets:
            return .standard(parameters: nil, encoding: .url)
        case .launches:
            return .standard(parameters: nil, encoding: .url)
        }
    }
    
    var path: String {
        switch self {
        case .rockets:
            return "rockets"
        case .launches:
            return "launches"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .rockets:
            return .get
        case .launches:
            return .get
        }
    }
    
}
