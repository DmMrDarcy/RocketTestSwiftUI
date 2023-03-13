//
//  HTTPHeaders.swift
//  RocketSwiftUIApp
//
//  Created by Dmitriy Lukyanov on 13.03.2023.
//

import UIKit

protocol HTTPHeadersSource: AnyObject {
    typealias Headers = Dictionary<String, String>
    
    var httpHeaders: Headers? { get }
}

class UserAgentHeader: HTTPHeadersSource {
    private let appName = "RocketSwiftUIApp"
    private let header = "User-Agent"
    private var headerValue: String;

    init() {
        let appVersion = Config.appVersion // x.y.z
        let systemVersion = "\(UIDevice.current.systemName)-\(UIDevice.current.systemVersion)";
        headerValue = "\(appName) version: \(appVersion), iOS version: \(systemVersion)"
    }

    var httpHeaders: Headers? {
        return [header: headerValue]
    }
}
