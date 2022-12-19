//
//  ClientsConfigurator.swift
//  Trending Repos
//
//  Created by Omar Labib on 18/12/2022.
//

import Foundation

enum ClientsConfigurator {
    static func configuredNetworkClient() -> NetworkClient {
        return URLSession.shared
    }

    static func configuredLocalStorageClient() -> LocalStorageClient {
        return UserDefaults.standard
    }
}
