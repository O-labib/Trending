//
//  NetworkService.swift
//  Trending Repos
//
//  Created by Omar Labib on 18/12/2022.
//

import Foundation

class ReposListNetworkService {
    let networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
}

extension ReposListNetworkService: ReposListRemoteRepository {
    func fetchRemoteRepos(_ completion: (Result<Response, NetworkError>) -> Void) {
    }
}
