//
//  RequestParameters.swift
//  RocketSwiftUIApp
//
//  Created by Dmitriy Lukyanov on 10.03.2023.
//

import Alamofire
enum RequestParameters {
    case standard(parameters: Parameters?, encoding: NetworkParameterEncoding)
}

enum NetworkParameterEncoding {
    case url
    case json
}

extension NetworkParameterEncoding {
    var alamofireEncoding: ParameterEncoding {
        switch self {
        case .json:
            return JSONEncoding.default
        case .url:
            return URLEncoding.default
        }
    }
}
