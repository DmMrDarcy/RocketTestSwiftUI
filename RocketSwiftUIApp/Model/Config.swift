//
//  Config.swift
//  RocketSwiftUIApp
//
//  Created by Dmitriy Lukyanov on 15.02.2023.
//

import Foundation
import Alamofire

public struct Config {
    public static var baseUrl = URL(string: "https://api.spacexdata.com/v4")!
}

extension Config {
    enum apiCall: String, Codable {
        case rockets
        case launches
        
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
}

