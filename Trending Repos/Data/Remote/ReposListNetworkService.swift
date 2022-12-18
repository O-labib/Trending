//
//  NetworkService.swift
//  Trending Repos
//
//  Created by Omar Labib on 18/12/2022.
//

import Foundation

class ReposListNetworkService: ReposListRemoteRepository {
    let networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
}
