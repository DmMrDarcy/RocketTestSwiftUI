//
//  Config.swift
//  RocketSwiftUIApp
//
//  Created by Dmitriy Lukyanov on 15.02.2023.
//

import Foundation

public protocol ConfigProtocol {
    static var appVersion: String { get }
}

public struct Config {
    init(){}

    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return dict
    }()
    
    // x.y.z
    public static var appVersion: String {
        guard let value = Config.infoDictionary["CFBundleShortVersionString"] as? String else {
            fatalError("App Version not set in plist for this environment")
        }

        return value
    }
}

extension Config {
    enum EndPoint: String, Codable {
        case rocket = "rocket"
        
        var url: URL {
            switch self {
            case .rocket:
                return URL(string: "https://api.spacexdata.com/v4")!
            }
        }
    }
}
