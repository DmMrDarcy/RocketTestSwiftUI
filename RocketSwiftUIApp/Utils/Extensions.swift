//
//  Extensions.swift
//  RocketSwiftUIApp
//
//  Created by Dmitriy Lukyanov on 15.02.2023.
//

import SwiftUI

extension AnyTransition {
    static var backslide: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .move(edge: .trailing),
            removal: .move(edge: .leading))
    }
}

extension Data {
    func decode<T: Decodable>() -> T? {
        let decoder = JSONDecoder()

        return try? decoder.decode(T.self, from: self)
    }
}

extension Encodable {
    var data: Data {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601

        guard let data = try? encoder.encode(self) else { return Data() }

        return data
    }
}
