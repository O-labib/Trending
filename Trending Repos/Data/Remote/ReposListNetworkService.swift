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
    func fetchRemoteRepos(_ completion: @escaping (Result<Response, Error>) -> Void) {
        guard let request = try?  EndPoints.trendingRepos.asURLRequest() else { return }
        
        networkClient.perform(request: request, completion: completion)
    }
}
