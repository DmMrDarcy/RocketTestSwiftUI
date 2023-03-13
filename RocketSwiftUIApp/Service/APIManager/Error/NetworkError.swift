//
//  NetworkError.swift
//  RocketSwiftUIApp
//
//  Created by Dmitriy Lukyanov on 07.03.2023.
//

import Foundation
import Alamofire

protocol DataConvertible {
    init(with data: Data) throws
}

public enum NetworkError: Error {
    case code(Int, NetworkErrorData?)
    case error(Error)
    case unknown
    case noInternet
    case timeout
}

extension NetworkError: CustomDebugStringConvertible {
    public var debugDescription: String {
        switch self {
        case .noInternet:
            return "No internet access"
        case .timeout:
            return "Timeout"
        case .unknown:
            return "Unknown error"
        case .error(let error):
            return error.localizedDescription
        case .code(let code, let data):
            return "Code: \(code) data: \(data?.debugDescription ?? "empty")"
        }
    }
}

extension NetworkError {
    public init(with error: Error) {
        switch error {
        
        case let networkError as NetworkError:
            self = networkError
            
        case let afError as AFError:
            switch afError {
            case .sessionTaskFailed(let sessionError):
                if sessionError is URLError {
                    self = .noInternet
                }
                else {
                    self = .unknown
                }
            default:
                self = .unknown
            }

        default:
            self = .error(error)
        }
    }

    public init?(with response: HTTPURLResponse, data: Data?) {
        let statusCode = response.statusCode

        switch statusCode {
        case 200 ..< 300:
            return nil
        case 504:
            self = NetworkError.timeout
        case 500, 502:
            self = NetworkError.unknown
        case 400, 404:
            var errorData: NetworkErrorData?
            if let data = data {
                errorData = try? NetworkErrorData(with: data)
            }
            self =  NetworkError.code(statusCode, errorData)
        default:
            self = NetworkError.unknown
        }
    }
    
}

extension NetworkError: Equatable {
    public static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.code(let codeLhs, _), .code(let codeRhs, _)):
            return codeLhs == codeRhs
        case (.error(let errorLhs), .error(let errorRhs)):
            return errorLhs.localizedDescription == errorRhs.localizedDescription
        case (.unknown, .unknown):
            return true
        case (.noInternet, .noInternet):
            return true
        case (.timeout, .timeout):
            return true
        case (.code, _), (.error, _), (.unknown, _), (.noInternet, _), (.timeout, _):
            return false
        }
    }
}

public struct NetworkErrorData: Decodable, DataConvertible {
    var code: String
    var message: String?

    private enum CodingKeys: String, CodingKey {
        case code
        case message
    }
}

extension NetworkErrorData: CustomDebugStringConvertible {
    public var debugDescription: String {
        return "Network Error Data code: \(code) message: \(message ?? "empty")"
    }
}
