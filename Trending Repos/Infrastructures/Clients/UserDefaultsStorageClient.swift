//
//  UserDefaultsStorageClient.swift
//  Trending Repos
//
//  Created by Omar Labib on 18/12/2022.
//

import Foundation

extension UserDefaults: LocalStorageClient {
    enum Keys {
        static let repos = "reposKey"
    }
    func store<T>(_ value: T) throws where T: Encodable {
        let data = try JSONEncoder().encode(value)
        setValue(data, forKey: Keys.repos)
    }

    func fetch<T>() throws -> T where T: Decodable {
        guard let data = data(forKey: Keys.repos) else {
            throw LocalStorageError.invalidStoredData
        }
        return try JSONDecoder().decode(T.self, from: data)
    }
}

enum LocalStorageError: Error {
    case invalidStoredData
}
