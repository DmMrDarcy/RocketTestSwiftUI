//
//  NetworkConfiguration.swift
//  RocketSwiftUIApp
//
//  Created by Dmitriy Lukyanov on 07.03.2023.
//

import Foundation
import Alamofire

class NetworkConfiguration {
    let defaultHttpHeaders: HTTPHeaders
    var endPoint: Config.EndPoint?

    init(endPoint: Config.EndPoint, headers: HTTPHeaders = [:]) {
        self.defaultHttpHeaders = headers
        self.endPoint = endPoint
    }

    var baseURL: URL? {
        endPoint?.url
    }
}
