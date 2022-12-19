//
//  LocalStorageClient.swift
//  Trending Repos
//
//  Created by Omar Labib on 18/12/2022.
//

protocol LocalStorageClient {
    func store<T: Encodable>(_ value: T) throws
    func fetch<T: Decodable>() throws -> T
}
