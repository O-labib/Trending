//
//  JsonDecoder+Default.swift
//  Trending Repos
//
//  Created by Omar Labib on 19/12/2022.
//

import Foundation

extension JSONDecoder {
    static var `default`: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}
